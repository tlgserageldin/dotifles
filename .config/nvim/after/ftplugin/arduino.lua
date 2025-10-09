-- Arduino-specific settings
-- This file is loaded when editing .ino files

-- Set buffer-local options
vim.bo.commentstring = "// %s"
vim.bo.cindent = true
vim.bo.cinoptions = ":0,l1,t0,g0,(0"

-- Arduino-specific abbreviations
vim.cmd("iabbrev <buffer> pinm pinMode")
vim.cmd("iabbrev <buffer> dw digitalWrite")
vim.cmd("iabbrev <buffer> dr digitalRead")
vim.cmd("iabbrev <buffer> aw analogWrite")
vim.cmd("iabbrev <buffer> ar analogRead")
vim.cmd("iabbrev <buffer> dl delay")
vim.cmd("iabbrev <buffer> ser Serial.begin")
vim.cmd("iabbrev <buffer> print Serial.print")
vim.cmd("iabbrev <buffer> println Serial.println")

-- Set up formatting for Arduino files
if vim.fn.executable("clang-format") == 1 then
  vim.bo.formatprg = "clang-format --style='{BasedOnStyle: Google, IndentWidth: 2}'"
end