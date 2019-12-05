ARCHITECTURE masterVersion OF phaseCounter IS

  signal ddsCounter: unsigned(step'range);

BEGIN
  ------------------------------------------------------------------------------
                                                                -- phase counter
  countPhase: process(reset, clock)
  begin
    if reset = '1' then
      ddsCounter <= (others => '0');
    elsif rising_edge(clock) then
      if en = '1' then
        ddsCounter <= ddsCounter + step;
      end if;
    end if;
  end process countPhase;

  phase <= ddsCounter;

END ARCHITECTURE masterVersion;
