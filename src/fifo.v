
module fifo
(
    input clk,
    input reset,
    input push,
    input [31:0] in,
    input pop,
    output reg [31:0] out
);
    
    reg [31:0] fifo_mem [7:0];
    reg [2:0] write_ptr = 0;
    reg [2:0] read_ptr = 0;
    reg full = 0;
    reg empty = 1;
    reg [3:0] count = 0;

    always @(negedge reset) begin
        write_ptr <= 0;
        read_ptr <= 0;
        out <= 0;
        full <= 0;
        empty <= 1;
        count <= 0;
    end

    always @(posedge clk) begin
        if (push && !pop && !full) begin
            fifo_mem[write_ptr] <= in;
            write_ptr <= (write_ptr + 1) % 8;
            empty <= 0;
            count <= count + 1;

            if (count == 8) begin
                full <= 1;
            end
        end
    end




    always @(negedge clk) begin
        if (pop && !push && !empty) begin
            out <= fifo_mem[read_ptr];
            read_ptr <= (read_ptr + 1) % 8;
            full <= 0;
            count <= count - 1;

            if (count == 0) begin
                empty <= 1;
            end
        end
    end

    /*always @(posedge clk or negedge reset) begin
        // Reset all regs
        if (!reset) begin
            write_ptr <= 0;
            read_ptr <= 0;
            out <= 0;
            full <= 0;
            empty <= 1;
        end else begin
            // Write data to FIFO
            if (push && !pop && !full) begin
                fifo_mem[write_ptr] <= in;
                write_ptr <= (write_ptr + 1) % DEPTH;
                empty <= 0;
                
                if ((write_ptr + 1) % DEPTH == read_ptr) begin
                    full <= 1;
                end
            end
            
            // Read data from FIFO
            if (pop && !push && !empty) begin
                out <= fifo_mem[read_ptr];
                read_ptr <= (read_ptr + 1) % DEPTH;
                full <= 0;
                
                if ((read_ptr + 1) % DEPTH == write_ptr) begin
                    empty <= 1;
                end
            end
        end
    end*/
endmodule
