return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio", -- <-- aqui está o fix
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dap.set_log_level("TRACE")
      print("DAP log: " .. vim.fn.stdpath("cache") .. "/dap.log")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
