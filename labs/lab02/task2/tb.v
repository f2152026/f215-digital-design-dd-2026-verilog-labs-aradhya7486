// tb.v
// Testbench for Task 2 (LUT ROM with Parameter Override)

module tb;

  // Parameter configuration for override testing
  parameter TEST_WIDTH = 8;
  parameter TEST_DEPTH = 8;

  // TODO: declare the inputs and outputs
  // Address bus needs $clog2(TEST_DEPTH) bits (3 bits for DEPTH=8)
  reg  [$clog2(TEST_DEPTH)-1:0] t_sel;
  wire [TEST_WIDTH-1:0]         t_dout;

  // TODO: instantiate DUT here with Parameter Overrides
  lut #(
    .WIDTH(TEST_WIDTH),
    .DEPTH(TEST_DEPTH)
  ) DUT (
    .sel (t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT); 
    end
  end

  integer i;

  initial begin
    // TODO: apply different input combinations
    // Loop sel through every valid memory address (0 to DEPTH-1)
    for (i = 0; i < TEST_DEPTH; i = i + 1) begin
      t_sel = i;
      #5;
    end
    
    $finish;
  end

  // Monitor output showing current address and read data value
  initial
    $monitor($time, " sel=%0d (%b) | dout=%0d", t_sel, t_sel, t_dout);

endmodule