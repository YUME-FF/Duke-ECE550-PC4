// Still under editing!
// Expected to be finished on Nov 3rd.
// Assign to @ZihanSheng
`timescale 1 ns / 100 ps

module processor_tb();
	// Control signals
	reg clock;                          // I: The master clock
	reg reset;                          // I: A reset signal

	// Imem
	wire [11:0] address_imem;           // O: The address of the data to get from imem
	reg [31:0] q_imem;                  // I: The data from imem

	// Dmem
	wire [11:0] address_dmem;           // O: The address of the data to get or put from/to dmem
	wire [31:0] data;                   // O: The data to write to dmem
	wire wren;                          // O: Write enable for dmem
	reg [31:0] q_dmem;                  // I: The data from dmem

	// Regfile
	wire ctrl_writeEnable;              // O: Write enable for regfile
	wire [4:0] ctrl_writeReg;           // O: Register to write to in regfile
	wire [4:0] ctrl_readRegA;           // O: Register to read from port A of regfile
	wire [4:0] ctrl_readRegB;           // O: Register to read from port B of regfile
	wire [31:0] data_writeReg;          // O: Data to write to for regfile
	reg [31:0] data_readRegA;           // I: Data from port A of regfile
	reg [31:0] data_readRegB;           // I: Data from port B of regfile

	// Tracking the number of errors
	integer errors;
	integer index;

	// Instantiate the processor
	processor processor_ut(clock, reset, address_imem, q_imem, address_dmem, data,
		wren, q_dmem, ctrl_writeEnable, ctrl_writeReg, ctrl_readRegA, ctrl_readRegB,
		data_writeReg, data_readRegA, data_readRegB);

	initial
	begin
		$display($time, " << Starting the Simulation >>");
		clock = 1'b0; // at time 0
		errors = 0;

		reset = 1'b1; // assert reset
		@(negedge clock); // wait until next negative edge of clock
		@(negedge clock); // wait until next negative edge of clock

		reset = 1'b0; // de-assert reset
		@(negedge clock); // wait until next negative edge of clock

		// TODO: test add
		// add $t0, $t4, $t7
		// 00000001100011110100000000100000
		// TODO: test addi
		// addi $t1, $t2, 0x0035 (53)
		// 00101001010010010000000000110101
		// TODO: test sub
		// sub $2, $3, $4
		// 00000000011001000001000000100010
		// TODO: test and
		// and $5, $6, $7
		// 00000000110001110010100000100100
		// TODO: test or
		// or $16, $17, $18
		// 00000010001100101000000000100101
		// TODO: test sll
		// sll $19, $20, 3
		// 00000000000101001001100011000000
		// TODO: test sra
		// sra $21, $22, 2
		// 00000000000101101010100010000011
		// TODO: test lw
		// lw $23, 0x0001($27)
		// 10001111011101110000000000000001
		// TODO: test sw
		// sw $25, 0x0001($30)
		// 10101111110110010000000000000001

		// Test regFile
		for(index = 0; index <= 31; index = index + 1) begin
			//writeRegister(index, 32'h0000DEAD);
			writeRegister(index, index*16 + 1);
			// Register 0 is always 0s
			if(index == 0) begin
				checkRegister(index, 32'h0);
			end
			else begin
				checkRegister(index, index*16 + 1);
			end
		end

		if (errors == 0) begin
			$display("The simulation completed without errors");
		end
		else begin
			$display("The simulation failed with %d errors", errors);
		end

		$stop;
    end

	// Clock generator
	always
		#10     clock = ~clock; // toggle

	// Task for checking add operation
	task check_add;
		input [31:0] instr;
	endtask

	// Task for regfile testing
	task check_sw;
	endtask

endmodule
