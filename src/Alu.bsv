import RV_ISA::*;

function Maybe#(Bit#(32)) execute32(RVALUOperator operator, Bit#(32) operand1, Bit#(32) operand2);
    let sum         = operand1 + operand2;
    let difference  = operand1 - operand2;
    let bitwise_and = operand1 & operand2;
    let bitwise_or  = operand1 | operand2;
    let bitwise_xor = operand1 ^ operand2;
    let sltu        = (operand1 < operand2 ? 1 : 0);
    let slt         = (begin
        Int#(32) signedOperand1 = unpack(pack(operand1));
        Int#(32) signedOperand2 = unpack(pack(operand2));
        (signedOperand1 < signedOperand2 ? 1 : 0);
    end);    

    let sll     = operand1 << operand2[4:0];
    let sra     = signedShiftRight(operand1, operand2[4:0]);
    let srl     = operand1 >> operand2[4:0];

    return case(operator)
        alu_ADD:    tagged Valid sum;
        alu_SUB:    tagged Valid difference;
        alu_AND:    tagged Valid bitwise_and;
        alu_OR:     tagged Valid bitwise_or;
        alu_XOR:    tagged Valid bitwise_xor;
        alu_SLTU:   tagged Valid sltu;
        alu_SLT:    tagged Valid slt;
        alu_SLL:    tagged Valid sll;
        alu_SRA:    tagged Valid sra;
        alu_SRL:    tagged Valid srl;
        default:    tagged Invalid;
    endcase;
endfunction

function Maybe#(Bit#(64)) execute64(RVALUOperator operator, Bit#(64) operand1, Bit#(64) operand2);
    let sum         = operand1 + operand2;
    let difference  = operand1 - operand2;
    let bitwise_and = operand1 & operand2;
    let bitwise_or  = operand1 | operand2;
    let bitwise_xor = operand1 ^ operand2;
    let sltu        = (operand1 < operand2 ? 1 : 0);
    let slt         = (begin
        Int#(64) signedOperand1 = unpack(pack(operand1));
        Int#(64) signedOperand2 = unpack(pack(operand2));
        (signedOperand1 < signedOperand2 ? 1 : 0);
    end);    

    let sll     = operand1 << operand2[5:0];
    let sra     = signedShiftRight(operand1, operand2[5:0]);
    let srl     = operand1 >> operand2[5:0];

    return case(operator)
        alu_ADD:    tagged Valid sum;
        alu_SUB:    tagged Valid difference;
        alu_AND:    tagged Valid bitwise_and;
        alu_OR:     tagged Valid bitwise_or;
        alu_XOR:    tagged Valid bitwise_xor;
        alu_SLTU:   tagged Valid sltu;
        alu_SLT:    tagged Valid slt;
        alu_SLL:    tagged Valid sll;
        alu_SRA:    tagged Valid sra;
        alu_SRL:    tagged Valid srl;
        default:    tagged Invalid;
    endcase;
endfunction

typeclass Execute#(numeric type xlen);
    function Maybe#(Bit#(xlen)) execute(RVALUOperator operator, Bit#(xlen) operand1, Bit#(xlen) operand2);
endtypeclass

instance Execute#(32);
    function execute = execute32;
endinstance

instance Execute#(64);
    function execute = execute64;
endinstance

typedef struct {
} AluCfg#(numeric type xlen);

interface AluIfc#(numeric type xlen);
    method Maybe#(Bit#(xlen)) execute(RVALUOperator operator, Bit#(xlen) operand1, Bit#(xlen) operand2);
endinterface

module mkAlu#(AluCfg#(xlen) cfg)(AluIfc#(xlen));
    method Maybe#(Bit#(xlen)) execute(RVALUOperator operator, Bit#(xlen) operand1, Bit#(xlen) operand2);
        return execute(operator, operand1, operand2);
    endmethod
endmodule
