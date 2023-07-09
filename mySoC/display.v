module display(
  input wire clk,
  input wire rst,
  input wire[31:0] data,
  output reg[7:0] led_en,
  output reg[7:0] led_cx
);

reg[19:0] cnt;
reg[4:0] cx;
parameter T = 20'd199999;//2ms

parameter n0=8'b1_1000000,n1=8'b1_1111001,n2=8'b1_0100100,n3=8'b1_0110000,n4=8'b1_0011001,
n5=8'b1_0010010,n6=8'b1_0000010,n7=8'b1_1111000,n8=8'b1_0000000,n9=8'b1_0011000,n10=8'b1_0001000,n11=8'b1_0000011,n12=8'b1_0100111,n13=8'b1_0100001,n14=8'b1_0000110,n15=8'b1_0001110;

//2ms周期计时�??
always @(posedge clk or posedge rst) begin//分频�??2ms
  if(rst) cnt<=20'd0;
  else if(cnt == T) cnt <= 20'd0;
  else cnt <= cnt + 1'd1;
end

//使能周期变化
always @(posedge clk or posedge rst) begin
  if(rst) led_en<=8'b1111_1111;
  else if(led_en == 8'b1111_1111) led_en<=8'b1111_1110;
  else if(cnt == T) led_en<={led_en[6:0], led_en[7]}; 
  else  led_en <=led_en;
end

//轮流为cx赋�??
always @(led_en) begin
  case(led_en)
    8'b1111_1110:cx = data[0]+data[1]*2+data[2]*4+data[3]*8;  //data[3:0]
    8'b1111_1101:cx = data[4]+data[5]*2+data[6]*4+data[7]*8;
    8'b1111_1011:cx = data[8]+data[9]*2+data[10]*4+data[11]*8;
    8'b1111_0111:cx = data[12]+data[14]*2+data[14]*4+data[15]*8;
    8'b1110_1111:cx = data[16]+data[18]*2+data[18]*4+data[19]*8;
    8'b1101_1111:cx = data[20]+data[22]*2+data[22]*4+data[23]*8;
    8'b1011_1111:cx = data[24]+data[26]*2+data[26]*4+data[27]*8;
    8'b0111_1111:cx = data[28]+data[30]*2+data[30]*4+data[31]*8;
    default:cx=5'd0;
  endcase
end

//再�?�过cx来改变led_cx
always @(*) begin
  case(cx)
    5'd0:led_cx=n0;
    5'd1:led_cx=n1;
    5'd2:led_cx=n2;
    5'd3:led_cx=n3;
    5'd4:led_cx=n4;
    5'd5:led_cx=n5;
    5'd6:led_cx=n6;
    5'd7:led_cx=n7;
    5'd8:led_cx=n8;
    5'd9:led_cx=n9;
    5'd10:led_cx=n10;
    5'd11:led_cx=n11;
    5'd12:led_cx=n12;
    5'd13:led_cx=n13;
    5'd14:led_cx=n14;
    5'd15:led_cx=n15;
    default:led_cx=n0;
  endcase
end

endmodule