//!topmodule mkAluexample_tb
import Alu::*;

module mkAluexample_tb(Empty);
    AluCfg#(32) alucfg32 = AluCfg {};
    AluIfc#(32) alu32 <- mkAlu(alucfg32);

    AluCfg#(64) alucfg64 = AluCfg {};
    AluIfc#(64) alu64 <- mkAlu(alucfg64);

    rule run_it;
        // TB doesn't do anything except denote success.
        $display(">>>PASS");
        $finish();
    endrule
endmodule
