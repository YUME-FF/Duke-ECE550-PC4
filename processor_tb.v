`timescale 1 ns / 100 ps

module processor_tb();
	// Control signals
	reg clock, reset;

	// Imem
	reg [11:0] address_imem;
	reg [31:0] q_imem;

	// Dmem
	reg [11:0] address_dmem;
	reg [31:0] data;
	reg wren;
	reg [31:0] q_dmem;

	// Regfile
	reg ctrl_writeEnable;
	reg [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	reg [31:0] data_writeReg;
	reg [31:0] data_readRegA, data_readRegB;

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

		// TODO: call testing functions

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
		#10     clock = ~clock;    // toggle
endmodule
