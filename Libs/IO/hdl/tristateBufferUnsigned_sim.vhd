ARCHITECTURE sim OF tristateBufferUnsigned IS
BEGIN
  out1 <= in1 after delay when OE = '1' else (others => 'Z') after delay;
END ARCHITECTURE sim;

