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

		// 0000 : 00000000000000000000000000000000;
    	// -- addi $1, $0, 5   # r1 = 5
		// 0001 : 00101000010000000000000000000101;
		// 	-- addi $2, $0, 3  # r2 = 3
		// 0002 : 00101000100000000000000000000011;
		// 	-- add  $3, $1, $2 # r3 = 5 + 3 = 8
		// 0003 : 00000000110000100010000000000000;
		// 	-- sub $4, $1, $2 	# r4 = r1 - r2 = 2
		// 0004 : 00000001000000100010000000000100;
		// 	-- and $5, $0, $1 	# r5 = 0
		// 0005 : 00000001010000000001000000001000;
		// 	-- and $6, $1, $2  # r6 = 1
		// 0006 : 00000001100000100010000000001000;
		// 	-- or  $7, $0, $2	# r7 = 3
		// 0007 : 00000001110000000010000000001100;
		// 	-- sll $8, $1, 2	# r8 = r1 * 4 = 20
		// 0008 : 00000010000000100000000100010000;
		// 	-- sra $9, $3, 1	# r9 = 4
		// 0009 : 00000010010001100000000010010100;
		// 	-- addi $10, $0, 345	# r10 = 345
		// 0010 : 00101010100000000000000101011001;
		// 	-- addi $11, $0, 567	# r11 = 567
		// 0011 : 00101010110000000000001000110111;
		// 	-- sw $10, 1($0)		# store 345 into address 1
		// 0012 : 00111010100000000000000000000001;
		// 	-- sw $11, 2($0)		# store 567 into address 2
		// 0013 : 00111010110000000000000000000010;
		// 	-- lw $12, 1($0)		# load 345 into r12
		// 0014 : 01000011000000000000000000000001;
		// 	-- lw $13, 2($0)		# load 567 into r13

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
