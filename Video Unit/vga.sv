module vga(input logic clk, output logic vgaclk, output logic hsync, vsync, output logic sync_b, blank_b, output logic[7:0]r,g,b);
	logic[9:0] x,y;
	pll vgapll(,inclk0(clk),.c0(vgaclk));
	vgaController vgaCont(vgaclk, hysync, vsync, sync_b, blank_b, x, y);
	videoGen videoGen(x, y, r, g, b);
endmodule

module vgaController #(parameter HACTIVE=10'd640,
									HFP = 10'd16,
									HSYN = 10'd96,
									HBP = 10'd48,
									HMAX = HACTIVE + HFP + HSYN + HBP,
									VBP = 10'd32,
									VACTIVE = 10'd480,
									VFP = 10'd11,
									VSYN = 10'd2,
									VMAX = VACTIVE + VFP + VSYN + VBP)
(input logic vgaclk,
output logic hsync, vsync, sync_b, blank_b,
output logic [9:0] x, y);

always @(posedge vgaclk) begin
x++;
if (x == HMAX) begin
x = 0;
y++;
if (y == VMAX) y = 0;
end
end

assign hsync = ~(hcnt >= HACTIVE + HFP & hcnt < HACTIVE + HFP + HSYN);
assign vsync = ~(vcnt >= VACTIVE + VFP & vcnt < VACTIVE + VFP + VSYN);
assign sync_b = hsync & vsync;

assign blank_b = (hcnt < HACTIVE) & (vcnt < VACTIVE);
endmodule

module videoGen(input logic [9:0] x, y, output logic [7:0] r, g, b);
logic pixel, inrect;
chargenrom chargenromb(y[8:3]+8’d65, x[2:0], y[2:0], pixel);
rectgen rectgen(x, y, 10’d120, 10’d150, 10’d200, 10’d230, inrect);
assign {r, b} = (y[3]==0) ? {{8{pixel}},8’h00} : {8’h00,{8{pixel}}};
assign g = inrect ? 8’hFF : 8’h00;
endmodule

module chargenrom(input logic [7:0] ch,
input logic [2:0] xoff, yoff,
output logic pixel);
logic [5:0] charrom[2047:0]; // character generator ROM
logic [7:0] line;

initial
$readmemb("charrom.txt", charrom);
// index into ROM to find line of character
assign line = charrom[yoff+{ch-65, 3’b000}]; // subtract 65 because A
// is entry 0

// reverse order of bits
assign pixel = line[3’d7-xoff];
endmodule


module rectgen(input logic [9:0] x, y, left, top, right, bot,
output logic inrect);

assign inrect = (x >= left & x < right & y >= top & y < bot);
endmodule