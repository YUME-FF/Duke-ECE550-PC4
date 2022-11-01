module control_circuit(opcode, Rwe, Rdst, ALUinB, ALUop, BR, DMwe, JP, Rwd, op_Rtpye, op_Addi, op_Sw, op_Lw);
	//input
	input [4:0] opcode;
	
	//Internal wire
	wire [4:0] opcode;
	wire Rwe, Rdst, ALUinB, ALUop, BR, DMwe, JP, Rwd, op_Rtpye, op_Addi, op_Sw, op_Lw;
	wire [2:0] op_Rtpye_Tmp;
	wire [2:0] op_Addi_Tmp;
	wire [2:0] op_Sw_Tmp;
	wire [2:0] op_Lw_Tmp;
	wire or_Rwe_Tmp;
	wire or_ALUinB_Tmp;
	
	//output
	output Rwe, Rdst, ALUinB, ALUop, BR, DMwe, JP, Rwd, op_Rtpye, op_Addi, op_Sw, op_Lw;
	
	//op_Rtpye 00000
	and and_Rtpye_0(op_Rtpye_Tmp[0], ~opcode[0], ~opcode[1]);
	and and_Rtpye_1(op_Rtpye_Tmp[1], ~opcode[2], ~opcode[3]);
	and and_Rtpye_2(op_Rtpye_Tmp[2], op_Rtpye_Tmp[0], op_Rtpye_Tmp[1]);
	and and_Rtpye_3(op_Rtpye, ~opcode[4], op_Rtpye_Tmp[2]);
	
	//op_Addi 01000
	and and_Addi_0(op_Addi_Tmp[0], ~opcode[0], ~opcode[1]);
	and and_Addi_1(op_Addi_Tmp[1], ~opcode[2], opcode[3]);
	and and_Addi_2(op_Addi_Tmp[2], op_Addi_Tmp[0], op_Addi_Tmp[1]);
	and and_Addi_3(op_Addi, ~opcode[4], op_Addi_Tmp[2]);
	
	//op_Sw 01011
	and and_Sw_0(op_Sw_Tmp[0], opcode[0], opcode[1]);
	and and_Sw_1(op_Sw_Tmp[1], ~opcode[2], opcode[3]);
	and and_Sw_2(op_Sw_Tmp[2], op_Sw_Tmp[0], op_Sw_Tmp[1]);
	and and_Sw_3(op_Sw, ~opcode[4], op_Sw_Tmp[2]);
	
	//op_Lw 00011
	and and_Lw_0(op_Lw_Tmp[0], opcode[0], opcode[1]);
	and and_Lw_1(op_Lw_Tmp[1], ~opcode[2], ~opcode[3]);
	and and_Lw_2(op_Lw_Tmp[2], op_Lw_Tmp[0], op_Lw_Tmp[1]);
	and and_Lw_3(op_Lw, ~opcode[4], op_Lw_Tmp[2]);
	
	//Rwe = Rtype + Addi + Lw
	or or_Rwe_0(or_Rwe_Tmp, op_Rtype, op_Addi);
	or or_Rwe_1(Rwe, or_Rwe_Tmp, op_Lw);
	
	//Rdst = Rtype
	assign Rdst = op_Rtpye;
	
	//ALUinB = Addi + Lw + Sw
	or or_ALUinB_0(or_ALUinB_Tmp, op_Addi, op_Lw);
	or or_ALUinB_1(ALUinB, or_ALUinB_Tmp, op_Sw);
	
	//ALUop = Beq(Not in this checkpoint)
	assign ALUop = 1'b0;
	
	//BR = Beq(Not in this checkpoint)
	assign BR = 1'b0;
	
	//DMwe = Sw
	assign DMwe = op_Sw;
	
	//JP = J(Not in this checkpoint)
	assign JP = 1'b0;
	
	//Rwd = Lw
	assign Rwd = op_Lw;
	
endmodule
