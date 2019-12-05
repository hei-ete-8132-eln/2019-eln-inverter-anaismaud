ARCHITECTURE masterVersion OF pwmModulator IS

  signal sawtooth1: signed(amplitude'high+1 downto 0);
  signal sawtooth, sawtoothLow, sawtoothHigh: signed(amplitude'range);
  signal even_odd: std_ulogic;

BEGIN
  ------------------------------------------------------------------------------
                                                            -- PWM with sawtooth
  buildSawtooth: process(reset, clock)
  begin
    if reset = '1' then
      sawtooth1 <= (others => '0');
    elsif rising_edge(clock) then
      if en = '1' then
        sawtooth1 <= sawtooth1 + 1;
      end if;
    end if;
  end process buildSawtooth;

  sawtooth <= sawtooth1(sawtooth'range);
  sawtoothLow  <= '1' & sawtooth(sawtooth'high downto 1) when doubleFrequency = '0'
    else '1' & sawtooth(sawtooth'high-1 downto 0);
  sawtoothHigh <= '0' & sawtooth(sawtooth'high downto 1) when doubleFrequency = '0'
    else '0' & sawtooth(sawtooth'high-1 downto 0);
  even_odd <= sawtooth1(sawtooth1'high);

  ------------------------------------------------------------------------------
                                                               -- PWM comparator
  compareToSawtooth: process(
    threeLevel, switchEvenOdd, even_odd,
    amplitude,
    sawtooth, sawtoothLow, sawtoothHigh
  )
  begin
    pwm1 <= '0';
    pwm2 <= '0';
    if threeLevel = '0' then
      pwm2 <= '1';
      if amplitude > sawtooth then
        pwm1 <= '1';
        pwm2 <= '0';
      end if;
    else  -- threeLevel = '1'
      if switchEvenOdd = '0' then
        if amplitude > sawtoothHigh then
          pwm1 <= '1';
        elsif amplitude < sawtoothLow then
          pwm2 <= '1';
        end if;
      else  -- threeLevel = '1' and switchEvenOdd = '1'
        if even_odd = '0' then
          if amplitude > sawtoothHigh then
            pwm1 <= '1';
          elsif amplitude < sawtoothLow then
            pwm2 <= '1';
          end if;
        else  -- even_odd = '1'
          pwm1 <= '1';
          pwm2 <= '1';
          if amplitude > sawtoothHigh then
            pwm2 <= '0';
          elsif amplitude < sawtoothLow then
            pwm1 <= '0';
          end if;
        end if;
      end if;
    end if;
  end process compareToSawtooth;

END ARCHITECTURE masterVersion;
