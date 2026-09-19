// Dataflow AND gate with delay
module and_df #(parameter DELAY = 1) (
  input  a,
  input  b,
  output y
);
  assign #DELAY y = a & b;
endmodule