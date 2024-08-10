module tb;

            // Inputs
            reg [6:0] address;
            reg [7:0] register;
            reg [7:0] data;
            reg [7:0] data_wr;
            reg clk;
            reg rw;

            // Outputs
            wire sda;
            wire scl;

            // Instantiate the Unit Under Test (UUT)
            master uut (
                        .address(address),
                        .register(register),
                        .clk(clk),
                        .rw(rw), 
                        .sda(sda),
                        .scl(scl),
                        .data(data),
                        .data_wr(data_wr)
            );

            initial begin
    // Initialize Inputs
    $dumpfile("ven_waveform.vcd");
    $dumpvars(1);
    address = 105;
    register = 7'b0100101;
    clk = 0;
    rw = 0; // Write operation
    data_wr = 20;

    // Wait 100 ns for global reset to finish
    #100;

    // Write operation: Sending data to the slave
    address = 7'b1101001;   // Set the I2C address
    register = 8'h5A;       // Set the register address
    data_wr = 8'h3C;        // Data to be written
    rw = 0;                 // Set to write mode
    #100;                   // Wait for the write operation to complete

    // Read operation: Requesting data from the slave
    rw = 1;                 // Set to read mode
    #100;                   // Wait for the read operation to complete

    // End of simulation
    $finish;
end

always
    #1 clk = !clk; // Generate clock signal with a period of 2 units

endmodule

