-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- -- Atalhos padrão LazyVim + mapeamento de debug com nvim-dap

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 🚀 Execução
map("n", "<F5>", function()
  require("dap").continue()
end, opts)
map("n", "<F10>", function()
  require("dap").step_over()
end, opts)
map("n", "<F11>", function()
  require("dap").step_into()
end, opts)
map("n", "<F12>", function()
  require("dap").step_out()
end, opts)

-- 🔴 Breakpoint
map("n", "<F9>", function()
  require("dap").toggle_breakpoint()
end, opts)

-- 🛑 Terminar
map("n", "<S-F5>", function()
  require("dap").terminate()
end, opts)

-- 🪟 Interface
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle DAP UI" })
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Start/Continue Debug" })
map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Step Into" })
map("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "Step Over" })
map("n", "<leader>dO", function()
  require("dap").step_out()
end, { desc = "Step Out" })
map("n", "<leader>dq", function()
  require("dap").terminate()
end, { desc = "Terminate Debug Session" })
map("n", "<leader>de", function()
  require("dapui").eval()
end, { desc = "Evaluate Expression" })
