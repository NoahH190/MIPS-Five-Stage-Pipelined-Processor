import cocotb
from cocotb.triggers import Timer

import random

# ALU control encodings
ALU_ADD  = 0
ALU_SUB  = 1
ALU_AND  = 2
ALU_OR   = 3
ALU_XOR  = 4
ALU_SLL  = 5
ALU_SRL  = 6
ALU_SRA  = 7
ALU_SLT  = 8
ALU_SLTU = 9

def to_signed(val, bits=32):
    """Convert unsigned value to signed integer."""
    if val & (1 << (bits - 1)):
        val -= 1 << bits
    return val

def to_unsigned(val, bits=32):
    """Convert signed integer to unsigned value."""
    if val < 0:
        val += 1 << bits
    return val & ((1 << bits) - 1)

@cocotb.test()
async def alu_test(dut):
    """Test the ALU module."""

    # Initialize inputs
    dut.i_src1.value = 0
    dut.i_alu_mux.value = 0
    dut.i_alu_ctrl.value = 0
    dut.i_shamt.value = 0

    await Timer(1, units='ns')

    # Helper function to run a test case
    async def run_test(op, src1, src2, shamt, expected_result, expected_zero):
        dut.i_alu_ctrl.value = op
        dut.i_src1.value = src1
        dut.i_alu_mux.value = src2
        dut.i_shamt.value = shamt
        
        await Timer(1, units='ns')
        
        # Check result
        # Use .value.integer for simple checks, but be careful with X/Z
        try:
            actual_result = int(dut.o_alu_result.value)
            actual_zero = int(dut.o_zero.value)
        except ValueError:
             raise TestFailure(f"Op {op}: Output contains X or Z. Result={dut.o_alu_result.value}, Zero={dut.o_zero.value}")

        if actual_result != expected_result:
            raise TestFailure(f"Op {op}: src1={src1:#x}, src2={src2:#x}, shamt={shamt} -> Expected {expected_result:#x}, got {actual_result:#x}")
        
        if actual_zero != expected_zero:
            raise TestFailure(f"Op {op}: Zero flag mismatch. Expected {expected_zero}, got {actual_zero}")

    # Test ADD
    for _ in range(10):
        a = random.randint(0, 0xFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFF)
        res = (a + b) & 0xFFFFFFFF
        zero = 1 if res == 0 else 0
        await run_test(ALU_ADD, a, b, 0, res, zero)

    # Test SUB
    for _ in range(10):
        a = random.randint(0, 0xFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFF)
        res = (a - b) & 0xFFFFFFFF
        zero = 1 if res == 0 else 0
        await run_test(ALU_SUB, a, b, 0, res, zero)

    # Test AND
    for _ in range(10):
        a = random.randint(0, 0xFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFF)
        res = a & b
        zero = 1 if res == 0 else 0
        await run_test(ALU_AND, a, b, 0, res, zero)

    # Test OR
    for _ in range(10):
        a = random.randint(0, 0xFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFF)
        res = a | b
        zero = 1 if res == 0 else 0
        await run_test(ALU_OR, a, b, 0, res, zero)

    # Test XOR
    for _ in range(10):
        a = random.randint(0, 0xFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFF)
        res = a ^ b
        zero = 1 if res == 0 else 0
        await run_test(ALU_XOR, a, b, 0, res, zero)

    # Test SLL
    for _ in range(10):
        a = random.randint(0, 0xFFFFFFFF)
        shamt = random.randint(0, 31)
        res = (a << shamt) & 0xFFFFFFFF
        zero = 1 if res == 0 else 0
        await run_test(ALU_SLL, a, 0, shamt, res, zero)

    # Test SRL
    for _ in range(10):
        a = random.randint(0, 0xFFFFFFFF)
        shamt = random.randint(0, 31)
        res = (a >> shamt)
        zero = 1 if res == 0 else 0
        await run_test(ALU_SRL, a, 0, shamt, res, zero)

    # Test SRA
    for _ in range(10):
        a = random.randint(0, 0xFFFFFFFF)
        shamt = random.randint(0, 31)
        signed_a = to_signed(a)
        res = (signed_a >> shamt)
        res = to_unsigned(res) # Convert back to unsigned for comparison
        zero = 1 if res == 0 else 0
        await run_test(ALU_SRA, a, 0, shamt, res, zero)

    # Test SLT (Signed Less Than)
    for _ in range(10):
        a = random.randint(0, 0xFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFF)
        signed_a = to_signed(a)
        signed_b = to_signed(b)
        res = 1 if signed_a < signed_b else 0
        zero = 1 if res == 0 else 0
        await run_test(ALU_SLT, a, b, 0, res, zero)

    # Test SLTU (Unsigned Less Than)
    for _ in range(10):
        a = random.randint(0, 0xFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFF)
        res = 1 if a < b else 0
        zero = 1 if res == 0 else 0
        await run_test(ALU_SLTU, a, b, 0, res, zero)

    dut._log.info("ALU Test Passed!")

class TestFailure(Exception):
    pass
