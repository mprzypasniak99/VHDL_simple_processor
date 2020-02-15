# VHDL simple processor
## Description
This project is built for Altera DE2 board. It contains a very simple design of a processor. Top-level entity is described in file "procesor.vhd". All the other files contain components.
## Instructions
It can handle 3 types of instructions :
- mv - assigning content of one register to another
- mvi - assigning value from switches to chosen register
- add_sub - adding or subtracting value of chosen register to/from value from register nr 3, and saving the result to register nr 3

Instruction length is 8 bits. It is sent to control unit via switches from 7 downto 0. Two most significant bits are intruction number:
- 00 - mv
- 01 - mvi
- 10 - add_sub
Next three bits contain number of a register which will have data saved to it (when using `mv` or `mvi` instructions). If instruction `add_sub` is chosen, then switch nr 3 determines if number from register chosen by next three bits, will be added or subtracted from contents of register nr 3.

So instruction format looks like this:
<p allign=center>`CCXXXYYY` <p>
where:
- C - bits that determine which instruction will be executed
- X - number of first register
- Y - number of second register
