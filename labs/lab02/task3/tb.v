// Self-checking testbench for 2-bit magnitude comparator (comp2)

module tb;

 
  reg  [1:0] t_a;
  reg  [1:0] t_b;
  wire       t_gt;
  wire       t_lt;
  wire       t_eq;

  
  reg exp_gt;
  reg exp_lt;
  reg exp_eq;

  integer i, j;
  integer errors = 0;
  integer total_tests = 0;

  
  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  // Waveform dumping setup
  reg [1024*8-1:0] vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

 
  initial begin
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;
        #5;

        
        exp_gt = (t_a > t_b);
        exp_lt = (t_a < t_b);
        exp_eq = (t_a == t_b);

        total_tests = total_tests + 1;

        
        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b | Got: GT=%b LT=%b EQ=%b | Expected: GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    $write("\n=========================================\n");
    if (errors == 0) begin
      $write("TEST PASSED: %0d / %0d tests passed.\n", total_tests - errors, total_tests);
    end else begin
      $write("TEST FAILED: %0d / %0d tests passed (%0d errors).\n", total_tests - errors, total_tests, errors);
    end
    $write("=========================================\n\n");

    $finish;
  end

endmodule