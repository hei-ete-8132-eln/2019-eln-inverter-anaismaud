ARCHITECTURE test OF risingDetector_tester IS

  constant clockFrequency: real := 100.0E6;
  constant clockPeriod: time := 1.0/clockFrequency * 1 sec;
  signal sClock: std_uLogic := '1';

  constant inputFrequency: real := clockFrequency / 5.0;
  constant inputPeriod: time := 1.0/inputFrequency * 1 sec;
  signal sInput: std_uLogic := '0';

BEGIN
  ------------------------------------------------------------------------------
                                                              -- clock and reset
  reset <= '1', '0' after 4*clockPeriod;

  sClock <= not sClock after clockPeriod/2;
  clock <= transport sClock after 9.0/10.0 * clockPeriod;

  ------------------------------------------------------------------------------
                                                                        -- mains
  sInput <= not sInput after inputPeriod/2;
  sigIn <= sInput;

END ARCHITECTURE test;
