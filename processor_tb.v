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
	reg [31:0] data_readRegB;            // I: Data from port B of regfile

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

		// TODO: Test imem
		
		// TODO: Test dmem
		
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

	// Functions for Imem testing

	// Functions for dmem testing

	// Functions for regfile testing
	task writeRegister;
		input [4:0] writeReg;
		input [31:0] value;

		begin
			@(negedge clock); // wait for next negedge of clock
			$display($time, " << Writing register %d with %h >>", writeReg, value);

			ctrl_writeEnable = 1'b1;
			ctrl_writeReg = writeReg;
			data_writeReg = value;

			@(negedge clock); // wait for next negedge, write should be done
			ctrl_writeEnable = 1'b0;
		end
	endtask

   // Task for reading
	task checkRegister;
		input [4:0] checkReg;
		input [31:0] exp;
		begin
			@(negedge clock); // wait for next negedge of clock

			ctrl_readRegA = checkReg; // test port A
			ctrl_readRegB = checkReg; // test port B

			@(negedge clock); // wait for next negedge, read should be done

			if(data_readRegA !== exp) begin
				 $display("**Error on port A: read %h but expected %h.", data_readRegA, exp);
				 errors = errors + 1;
			end
			else if(data_readRegB !== exp) begin
				$display("**Error on port B: read %h but expected %h.", data_readRegB, exp);
				errors = errors + 1;
			end
			else begin
				$display($time, "	port A read %h matches expected %h. ", data_readRegA, exp);
				$display($time, "	port B read %h matches expected %h. ", data_readRegB, exp);
			end
	  end
	endtask
endmodule
