module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: Derive an equation for each state flip-flop.
    reg [3:0] states [3:0];
    assign states[A] = 4'b0001;
    assign states[B] = 4'b0010;
    assign states[C] = 4'b0100;
    assign states[D] = 4'b1000;
    
    always@(*) begin
        /*每次对next_state赋值前要进行清零，保证输出结果的准确性*/
        next_state[0] = 1'b0;
        next_state[1] = 1'b0;
        next_state[2] = 1'b0;
        next_state[3] = 1'b0;
        
        case(state) 
            states[A] : next_state = (in) ? states[B] : states[A];
            states[B] : next_state = (in) ? states[B] : states[C];
            states[C] : next_state = (in) ? states[D] : states[A];
            states[D] : next_state = (in) ? states[B] : states[C];
            default : begin
                if(state[0]) begin
                    if(in) begin
                        next_state[1] <= 1'd1; 
                    end else begin
                        next_state[0] <= 1'd1; 
                    end
                end 
                
                if(state[1]) begin
                    if(in) begin
                        next_state[1] <= 1'd1; 
                    end else begin
                        next_state[2] <= 1'd1; 
                    end
                end
                
                if(state[2]) begin
                    if(in) begin
                        next_state[3] <= 1'd1; 
                    end else begin
                        next_state[0] <= 1'd1; 
                    end
                end
                
                if(state[3]) begin
                    if(in) begin
                        next_state[1] <= 1'd1; 
                    end else begin
                        next_state[2] <= 1'd1; 
                    end
                end
                
            end
        endcase
        
    end

    // Output logic: 
    assign out = (state[D]) ? 1'd1 : 1'd0;

endmodule
