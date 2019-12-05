ARCHITECTURE test OF inverterControl_tester IS
                                                            -- clock and enables
  constant clockPeriod: time := 1.0/clockFrequency * 1 sec;
  signal sClock: std_uLogic := '1';
                                                                     -- controls
  constant mainsPeriod: time := 1.0/mainsFrequency * 1 sec;
  constant modePeriod: time := 2*mainsPeriod;
  signal threeLevel_int: std_uLogic;
                                                                      -- lowpass
  constant lowpassShift: positive := 12;
  signal pwm1, pwm2: std_uLogic;
  signal pwm: integer;
  signal lowpassAccumulator1, lowpassAccumulator2: real := 0.0;
  signal lowpassOutput1, lowpassOutput2: real := 0.0;
  signal pwmFiltered: real := 0.0;
                                                           -- period measurement
  signal lastTriggerRisingEdge : time := 0 sec;
  signal measuredPeriod : time := mainsPeriod;
  signal measuredFrequency : real := mainsFrequency;
                                                      -- non-overlap measurement
  signal lastPwmHighFallingEdge : time := 0 sec;
  signal lastPwmLowFallingEdge : time := 0 sec;
  signal measuredDeadTime : time := nonOverlapPeriod;
  signal measuredDeadTimeNs : positive := nonOverlapPeriod / 1 ns;

BEGIN
  ------------------------------------------------------------------------------
                                                              -- clock and reset
  reset <= '1', '0' after 4*clockPeriod;

  sClock <= not sClock after clockPeriod/2;
  clock <= transport sClock after 9.0/10.0 * clockPeriod;

  ------------------------------------------------------------------------------
                                                                     -- controls
  threeLevel_int <= '0', '1' after modePeriod;
  threeLevel <= threeLevel_int;

  switchEvenOdd <= '0', '1' after 2*modePeriod;

  doubleFrequency <= '0', '1' after 3*modePeriod;

  ------------------------------------------------------------------------------
                                                              -- sampling enable
  sampleEn <= '1';
                                                             -- PWM count enable
  pwmCountEn <= '1';

  ------------------------------------------------------------------------------
                                                                      -- lowpass
  pwm1 <= '1' when pwm1High = '1'
    else '0' when pwm1Low_n = '1';

  pwm2 <= '1' when pwm2High = '1'
    else '0' when pwm2Low_n = '1';

  pwm <= 1 when (pwm1 = '1') and (pwm2 = '0')
    else -1 when (pwm1 = '0') and (pwm2 = '1')
    else 0;

  lowpassIntegrator: process
  begin
    wait until rising_edge(sClock);
    if pwm1 = '1' then
      lowpassAccumulator1 <= lowpassAccumulator1 - lowpassOutput1 + 1.0;
    else
      lowpassAccumulator1 <= lowpassAccumulator1 - lowpassOutput1 - 1.0;
    end if;
    if pwm2 = '1' then
      lowpassAccumulator2 <= lowpassAccumulator2 - lowpassOutput2 + 1.0;
    else
      lowpassAccumulator2 <= lowpassAccumulator2 - lowpassOutput2 - 1.0;
    end if;
  end process lowpassIntegrator;

  lowpassOutput1 <= lowpassAccumulator1 / 2.0**lowpassShift;
  lowpassOutput2 <= lowpassAccumulator2 / 2.0**lowpassShift;

  pwmFiltered <= lowpassOutput1 - lowpassOutput2;

  ------------------------------------------------------------------------------
                                                           -- period measurement
  updatePeriodMeasurement: process(trigger)
  begin
    if rising_edge(trigger) then
      measuredPeriod <= now - lastTriggerRisingEdge;
      lastTriggerRisingEdge <= now;
    end if;
  end process updatePeriodMeasurement;

  measuredFrequency <= 1.0 / ( real(measuredPeriod / 1 ns) * 1.0E-9 );

  ------------------------------------------------------------------------------
                                                        -- dead time measurement
  updateDeadTimeMeasurement: process(pwm1High, pwm1Low_n)
  begin
    if falling_edge(pwm1High) then
      lastPwmHighFallingEdge <= now;
    end if;
    if falling_edge(pwm1Low_n) then
      lastPwmLowFallingEdge <= now;
    end if;
    if rising_edge(pwm1High) then
      measuredDeadTime <= now - lastPwmLowFallingEdge;
    end if;
    if rising_edge(pwm1Low_n) then
      measuredDeadTime <= now - lastPwmHighFallingEdge;
    end if;
  end process updateDeadTimeMeasurement;

  measuredDeadTimeNs <= measuredDeadTime / 1 ns;

END ARCHITECTURE test;
