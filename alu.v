module alu(
    input[31:0] a,
    input[31:0] b;
    input[3:0] OpCode,
    input cin,
    output[31:0] result,
    output zero,
    output cout,
    output negative;
    output overflow,
);

    localparam AND = 4'b0000;
    localparam EOR = 4'b0001;
    localparam SUB = 4'b0010;
    localparam RSB = 4'b0011;
    localparam ADD = 4'b0100;
    localparam ADC = 4'b0101;
    localparam SBC = 4'b0110;
    localparam RSC = 4'b0111;
    localparam TST = 4'b1000;
    localparam TEQ = 4'b1001;
    localparam CMP = 4'b1010;
    localparam CMN = 4'b1011;
    localparam ORR = 4'b1100;
    localparam MOV = 4'b1101;
    localparam BIC = 4'b1110;
    localparam MVN = 4'b1111;

    always@(a, b, OpCode, cin) begin
        overflow <= 1'b0;
        cout <= 1'b0;
        case(OpCode)
            AND: assign result <= a & b;

            EOR: assign result <= a ^ b;

            SUB:begin
                    assign result <= a - b;
                    assign cout <= a < b ? 1 : 0;
                    assign zero = (result == 0) ? 1 : 0;
                end

            RSB:begin
                    assign result <= b - a;
                    assign cout <= b < a ? 1 : 0;
                    assign zero = (result == 0) ? 1 : 0;
                end
        
            ADD:begin
                    assign {cout,result} <= a + b;
                    assign zero = (result == 0) & (cout == 0) ? 1 : 0;
                end

            ADC:begin
                    assign {cout,result} <= a + b + cin;
                    assign zero = (result == 0) & (cout == 0) ? 1 : 0;
                end

            SBC:begin
                    assign {cout,result} <= a - b + cin - 1;
                    assign zero = (result == 0) & (cout == 0) ? 1 : 0;
                end

            RSC:begin
                    assign {cout,result} <= b - a + cin - 1;
                    assign zero = (result == 0) & (cout == 0) ? 1 : 0;
                end

            TST:begin
                    assign zero <= ((a & b) == 0) ? 1 : 0;
                end

            TEQ:begin
                    assign zero <= ((a ^ b) == 0) ? 1 : 0;
                end

            CMP:begin
                    assign zero <= ((a - b) == 0) ? 1 : 0;
                end

            CMN:begin
                    assign zero <= ((a + b) == 0) ? 1 : 0;
                end

            ORR:begin
                    assign result <= a | B;
                    assign zero <= ((a | b) == 0) ? 1 : 0;
                end

            MOV:begin
                    assign result <= b;
                end

            BIC:begin
                    assign result <= a & ~b;
                end

            MVN:begin
                    assign result <= ~b;
                end
                
        endcase
    end
endmodule
