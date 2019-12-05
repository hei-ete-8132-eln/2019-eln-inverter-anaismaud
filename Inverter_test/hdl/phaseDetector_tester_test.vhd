ARCHITECTURE test OF phaseDetector_tester IS

  constant clockFrequency: real := 100.0E6;
  constant clockPeriod: time := 1.0/clockFrequency * 1 sec;
  signal sClock: std_uLogic := '1';

  constant mainsFrequency: real := 50.0E3;
  constant mainsPeriod: time := 1.0/mainsFrequency * 1 sec;
  signal fbPeriod: time := mainsPeriod;

BEGIN
  ------------------------------------------------------------------------------
                                                              -- clock and reset
  reset <= '1', '0' after 4*clockPeriod;

  sClock <= not sClock after clockPeriod/2;
  clock <= transport sClock after 9.0/10.0 * clockPeriod;

  ------------------------------------------------------------------------------
                                                                        -- mains
  process
  begin
    refPhase <= '0';
    wait for mainsPeriod - clockPeriod;
    refPhase <= '1';
    wait for clockPeriod;
  end process;

  ------------------------------------------------------------------------------
                                                                    -- generator
  fbPeriod <= mainsPeriod + mainsPeriod/10,
              mainsPeriod - mainsPeriod/10 after 500 us;

  process
  begin
    fbPhase <= '0';
    wait for fbPeriod - clockPeriod;
    fbPhase <= '1';
    wait for clockPeriod;
  end process;

END ARCHITECTURE test;
