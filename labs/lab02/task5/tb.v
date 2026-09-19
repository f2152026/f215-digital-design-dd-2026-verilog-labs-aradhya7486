
// Self-checking testbench for alu.v

module tb;

  reg        t_op;
  reg  [3:0] t_a;
  reg  [3:0] t_b;
  wire [3:0] t_result;

  reg  [3:0] exp_result;

  integer i, j, k;
  integer errors = 0;
  integer total_tests = 0;

 
  alu DUT (
    .op     (t_op),
    .a      (t_a),
    .b      (t_b),
    .result (t_result)
  );

  // Waveform dump setup
  reg [1024*8-1:0] vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  initial begin
    // Test 1: Exhaustive check of all input combinations
    for (i = 0; i < 2; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        for (k = 0; k < 16; k = k + 1) begin
          t_op = i[0];
          t_a  = j[3:0];
          t_b  = k[3:0];
          #5;

          exp_result = (t_op == 1'b0) ? (t_a + t_b) : (t_a - t_b);
          total_tests = total_tests + 1;

          if (t_result !== exp_result) begin
            $display("FAIL at time %0t: op=%b a=%0d b=%0d | got=%0d exp=%0d",
                     $time, t_op, t_a, t_b, t_result, exp_result);
            errors = errors + 1;
         
          end
          
        end
      end
    end

    
    t_a  = 4'd9;
    t_b  = 4'd4;
    t_op = 1'b0; 
    #5;
    
    t_op = 1'b1; 
    #5;
    exp_result = t_a - t_b;
    total_tests = total_tests + 1;

    if (t_result !== exp_result) begin
      $display("FAIL Sensitivity Test at time %0t: op changed to 1 with fixed a=%0d b=%0d | got=%0d exp=%0d",
               $time, t_a, t_b, t_result, exp_result);
      errors = errors + 1;
    end

    
    $write("\n=========================================\n");
    if (errors == 0) begin
      $write("TEST PASSED: All %0d tests passed cleanly.\n", total_tests);
    end else begin
      $write("TEST FAILED: %0d / %0d tests passed (%0d errors).\n",
             total_tests - errors, total_tests, errors);
    end
    $write("=========================================\n\n");

    $finish;
  end



endmodule