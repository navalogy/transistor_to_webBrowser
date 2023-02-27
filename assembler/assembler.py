import os
import sys

labels = []
operands = []
regs = []

# condition codes (page -20)
conditions = [
 "EQ", "NE", "CS", "CC",
 "MI", "PL", "VS", "VC",
 "HI", "LS", "GE", "LT",
 "GT", "LE"]

dp_instr = {
"AND":"0000",
"EOR":"0001",
"SUB":"0010",
"RSB":"0011", 
"ADD":"0100",
"ADC":"0101",
"SBC":"0110",
"RSC":"0111",
"TST":"1000",
"TEQ":"1001",
"CMP":"1010",
"CMN":"1011", 
"ORR":"1100",
"MOV":"1101", 
"BIC":"1110", 
"MVN":"1111"
}

def createBinaryFile(binary):
    f = open("binary.obj","a")
    f.write(binary)
    f.close()


# _dpi_format = _InstructionFormat("Cond 0 0 I Opcode S Rn Rd Operand2") (page-23)
def parse_dp_instr(line, lineNo):
    line = line.strip()
    line.split(" ")
    opcode = line[0]

    for i in dp_instr:
        if opcode == i:
            opcode = dp_instr[i]

    # get value of registers from array
    if len(line) > 3:
        source_reg = line[1]
        source_reg = source_reg.split(",")[0]
        dest_reg = line[2]
        dest_reg = dest_reg.split(",")[0] 
        operand_reg = line[3]
    else: 
        source_reg = line[1].split(",")[0]
        operand_reg = line[2].split(",")[0]
        dest_reg = '' 
    for reg in regs:
        for k,v in reg.items(): 
            if k == dest_reg: 
                dest_reg = v
            if k == operand_reg: 
                operand_reg = v

    binary = "0000"+"00"+"0"+opcode+"1"+operand_reg+dest_reg # no condition check and offset .. default 0000 00
    createBinaryFile(binary)
