import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer
import random

@cocotb.test()
async def register_file_test(dut):
    """Test the Register File module."""

    # Create a 10ns clock (100 MHz)
    clock = Clock(dut.i_clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Initialize inputs
    dut.i_reset.value = 1
    dut.i_wb_data.value = 0
    dut.i_RS.value = 0
    dut.i_RT.value = 0
    dut.i_mux_addr.value = 0

    # Wait for a few clock cycles in reset
    await RisingEdge(dut.i_clk)
    await RisingEdge(dut.i_clk)
    dut.i_reset.value = 0
    await RisingEdge(dut.i_clk)

    dut._log.info("Reset complete. Verifying all registers are 0.")
    
    # Verify all registers are 0 after reset
    # We can check by reading them out via RS and RT
    for i in range(32):
        dut.i_RS.value = i
        dut.i_RT.value = i
        await Timer(1, units='ns') # Allow combinational logic to settle
        assert dut.o_src1.value == 0, f"Register {i} not 0 after reset! Got {dut.o_src1.value}"
        assert dut.o_src2.value == 0, f"Register {i} not 0 after reset! Got {dut.o_src2.value}"

    dut._log.info("Write/Read Test")

    # Write random values to all registers (except 0)
    expected_values = [0] * 32
    for i in range(1, 32):
        val = random.randint(0, 0xFFFFFFFF)
        expected_values[i] = val
        
        # Setup write
        dut.i_mux_addr.value = i
        dut.i_wb_data.value = val
        
        await RisingEdge(dut.i_clk)
        
        # Verify write happened by reading back immediately (optional, or check later)
        # Let's check later to ensure persistence

    # Disable write
    dut.i_mux_addr.value = 0
    dut.i_wb_data.value = 0
    await RisingEdge(dut.i_clk)

    # Verify values
    for i in range(32):
        dut.i_RS.value = i
        dut.i_RT.value = i
        await Timer(1, units='ns')
        
        expected = expected_values[i]
        assert dut.o_src1.value == expected, f"Register {i} read mismatch on src1! Expected {expected:#x}, got {dut.o_src1.value}"
        assert dut.o_src2.value == expected, f"Register {i} read mismatch on src2! Expected {expected:#x}, got {dut.o_src2.value}"

    dut._log.info("Register 0 Write Test")
    # Try to write to register 0
    dut.i_mux_addr.value = 0
    dut.i_wb_data.value = 0xDEADBEEF
    await RisingEdge(dut.i_clk)
    
    # Disable write
    dut.i_mux_addr.value = 0 
    await RisingEdge(dut.i_clk)

    # Verify register 0 is still 0
    dut.i_RS.value = 0
    await Timer(1, units='ns')
    assert dut.o_src1.value == 0, f"Register 0 was overwritten! Got {dut.o_src1.value}"

    dut._log.info("Register File Test Passed!")
