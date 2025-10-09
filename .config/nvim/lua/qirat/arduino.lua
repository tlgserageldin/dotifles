-- Arduino configuration
-- Set Arduino IDE path (adjust for your system)
vim.g.arduino_cmd = '/Applications/Arduino.app/Contents/MacOS/Arduino'
vim.g.arduino_dir = '/Applications/Arduino.app'

-- Arduino file type detection (needs to be set early)
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.ino", "*.pde"},
  callback = function()
    vim.bo.filetype = "arduino"
  end,
})

-- Also use the newer filetype API as backup
vim.filetype.add({
  extension = {
    ino = "arduino",
    pde = "arduino",
  },
})

-- Arduino specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "arduino",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.keymap.set("n", "<leader>ac", ":ArduinoChooseBoard<CR>", { buffer = buf, desc = "Choose Arduino Board" })
    vim.keymap.set("n", "<leader>av", ":ArduinoVerify<CR>", { buffer = buf, desc = "Verify Arduino Sketch" })
    vim.keymap.set("n", "<leader>au", ":ArduinoUpload<CR>", { buffer = buf, desc = "Upload Arduino Sketch" })
    vim.keymap.set("n", "<leader>as", ":ArduinoSerial<CR>", { buffer = buf, desc = "Open Arduino Serial Monitor" })
    vim.keymap.set("n", "<leader>ab", ":ArduinoChooseBaud<CR>", { buffer = buf, desc = "Choose Arduino Baud Rate" })
  end,
})