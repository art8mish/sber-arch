`timescale 1ns / 1ps

module tb_shift_register_with_dac;

    // Входы
    reg clk;
    reg rst;

    // Выходы
    wire phi0;
    wire [2:0] u_out;

    // Подключаем тестируемый модуль
    shift_register_with_dac uut (
        .clk(clk),
        .rst(rst),
        .phi0(phi0),
        .u_out(u_out)
    );

    // Генерация тактового сигнала: 50 нс период (20 МГц)
    always #25 clk = ~clk;

    // Начальная последовательность
    initial begin
        $display("Time\tclk\trst\tPhi0\tU_out\tQ");

        // Начальные значения
        clk = 0;
        rst = 1;

        // Сброс
        #50;
        rst = 0;

        // Наблюдаем работу в течение 20 тактов
    end
endmodule