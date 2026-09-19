// mux_beh.v
// 2-to-1 multiplexer, BEHAVIORAL style.
//
// This file does not compile as-is. Find the bug and fix it before moving on.
// Hint: think carefully about which port should be a net and which should be
// a variable in behavioral modeling.

module mux_beh (
  input       I0,
  input       I1,
  input       S,
  output reg Y
);
// behavioral modeling uses procedural blocks always/initial that require a storage element to hold assigned values across simulation time steps till the next procedural update
// dataflow modeling uses continuous assignments 'assign' which represent physical connections driven continuously by logic gates that must update whenever their inputs are changed
// the simulator wouldn't know if the signal is meant to be a continuously driven hardware wire or a procedurally stored variable, leading to a compilation error due to conflicting assignment semantics

  always @(*) begin
    if (S)
      Y = I1;
    else
      Y = I0;
  end

endmodule
