# RISC-V simple counter program
#
# Stanislav Zhelnio, 2020
#

        .text

start:  addi    a0, zero, 0             # count = 0
        addi    a2, zero, 8             # max = 8
push_l: addi    a0, a0, 1               # count += 1
        sw      a0, 0(a0)               # push count
        bne     a0, a2, push_l          # if count <= max then push_l
        addi    a2, zero, 0             # min = 0
        addi    a3, zero, 1             # expected = 1 (для проверки pop)

pop_l:  lw      a1, 0(a1)               # pop check
        bne     a1, a3, end             # если значение не совпало с ожидаемым, ошибка
        addi    a3, a3, 1               # ожидаемое значение увеличиваем
        addi    a0, a0, -1              # count -= 1
        bne     a0, a2, pop_l           # если count > min, продолжаем pop

end:    beq     zero, zero, end         # бесконечный цикл
