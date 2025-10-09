-- lua/qirat/msp430.lua
-- MSP430 project detection and configuration

local M = {}

-- Function to detect if we're in an MSP430 project
local function is_msp430_project()
  -- Look for MSP430 indicators in current directory and parents
  local patterns = {
    "Makefile",  -- Check for our Makefile
    "*.c",       -- C files (common)
    "src/*.c",   -- Our project structure
  }

  -- Check if Makefile contains MSP430 references
  local makefile = vim.fn.glob("Makefile")
  if makefile ~= "" then
    local content = vim.fn.readfile(makefile)
    for _, line in ipairs(content) do
      if string.match(line, "msp430") or
         string.match(line, "cl430") or
         string.match(line, "MSP430") then
        return true
      end
    end
  end

  return false
end

-- Setup MSP430-specific configuration
function M.setup()
  if not is_msp430_project() then
    return
  end

  -- Set compiler for :make
  vim.opt_local.makeprg = "make"

  -- Add MSP430 include paths for gf (goto file) and completions
  local msp430_paths = {
    "/Applications/ti/ccs2020/ccs/ccs_base/msp430/include",
    "/Applications/ti/ccs2020/ccs/tools/compiler/ti-cgt-msp430_21.6.1.LTS/include",
    "src",  -- Local source directory
  }

  for _, path in ipairs(msp430_paths) do
    vim.opt_local.path:append(path)
  end

  -- MSP430-specific key mappings
  local opts = { buffer = true, silent = true }

  -- Add MSP430-specific syntax highlighting
  vim.cmd([[
    syntax keyword cConstant BIT0 BIT1 BIT2 BIT3 BIT4 BIT5 BIT6 BIT7
    syntax keyword cConstant WDTCTL WDTPW WDTHOLD
    syntax keyword cConstant P1DIR P1OUT P1IN P1IE P1IFG P1REN P1SEL
    syntax keyword cConstant P2DIR P2OUT P2IN P2IE P2IFG P2REN P2SEL
    syntax keyword cConstant P3DIR P3OUT P3IN P3REN P3SEL
    syntax keyword cConstant P4DIR P4OUT P4IN P4REN P4SEL
    syntax keyword cConstant TACTL TACCTL0 TACCTL1 TAR TACCR0 TACCR1
    syntax keyword cConstant UCA0CTL0 UCA0CTL1 UCA0BR0 UCA0BR1 UCA0MCTL
    syntax keyword cConstant UCA0STAT UCA0RXBUF UCA0TXBUF UCA0ABCTL
    syntax keyword cConstant UCB0CTL0 UCB0CTL1 UCB0BR0 UCB0BR1
    syntax keyword cConstant PMMPW PMMCTL0 SVSMHCTL SVSMLCTL SVSMIO
    syntax keyword cConstant FRCTL0 GCCTL0 GCCTL1
  ]])
  
  -- Print confirmation
  print("MSP430 project detected")
end

return M
