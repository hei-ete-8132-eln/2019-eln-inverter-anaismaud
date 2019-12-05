ARCHITECTURE test OF nonOverlap_tester IS
                                                                        -- clock
  constant clockPeriod: time := 1.0/clockFrequency * 1 sec;
  signal sClock: std_uLogic := '1';
                                                                          -- PWM
  signal pwmCount, pwmSawtooth: natural := 0;
                                                     -- non-overlap verification
  constant minDeadTime: time := ((2**nonOverlapCounterBitNb)-1) * clockPeriod;
  signal lastFallTime: time := 0 sec;
  signal deadTime: time := minDeadTime;
  signal lastWasPwm: boolean;

BEGIN
  ------------------------------------------------------------------------------
                                                              -- clock and reset
  reset <= '1', '0' after 4*clockPeriod;

  sClock <= not sClock after clockPeriod/2;
  clock <= transport sClock after 9.0/10.0 * clockPeriod;

  ------------------------------------------------------------------------------
                                                                          -- PWM
  generateSawtooth: process(sClock)
  begin
    if pwmSawtooth < 2**pwmBitNb-1 then
      pwmSawtooth <= pwmSawtooth + 1;
    else
      pwmSawtooth <= 0;
    end if;
  end process generateSawtooth;

  generatePwm: process
  begin
    for index in 0 to 2**pwmBitNb-1 loop
      wait until pwmSawtooth = 0;
      pwmCount <= pwmCount + 1;
    end loop;
    wait;
  end process generatePwm;

  pwmIn <= '1' when pwmCount > pwmSawtooth
    else '0';

  ------------------------------------------------------------------------------
                                                                 -- drive Enable
  enableFirstRamp: process
  begin
    driveEn <= '1';
    wait until pwmCount = 2**pwmBitNb-1;
    wait for 10* 2**pwmBitNb * clockPeriod;
    driveEn <= '0';
    wait;
  end process enableFirstRamp;

  ------------------------------------------------------------------------------
                                                            -- check non overlap
  getDeadTime: process(pwmOut, pwmOut_n)
  begin
    if falling_edge(pwmOut) then
      lastFallTime <= now;
      lastWasPwm <= true;
    elsif falling_edge(pwmOut_n) then
      lastFallTime <= now;
      lastWasPwm <= false;
    elsif rising_edge(pwmOut) then
      if not lastWasPwm then
        deadTime <= now - lastFallTime;
      end if;
    elsif rising_edge(pwmOut_n) then
      if lastWasPwm then
        deadTime <= now - lastFallTime;
      end if;
    end if;
  end process getDeadTime;

  checkDeadTime: process(deadTime)
  begin
    assert deadTime >= minDeadTime
      report "Dead time violation"
      severity failure;
  end process checkDeadTime;

END ARCHITECTURE test;
