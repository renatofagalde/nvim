return {
  "leoluz/nvim-dap-go",
  ft = "go",
  config = function()
    require("dap-go").setup({
      dap_configurations = {
        {
          type = "go",
          name = "🚀 golang-test → cmd/web",
          request = "launch",
          cwd = "${workspaceFolder}/webapp", -- pasta do go.mod
          program = "${workspaceFolder}/webapp/cmd/web", -- pasta do main.go
          args = {}, -- ok lista vazia
          buildFlags = "",
          -- env = vim.empty_dict(),                      -- remova ou use vim.empty_dict()
        },
      },
      -- opcional: garanta qual dlv usar
      delve = { path = vim.fn.exepath("dlv") },
    })
  end,
}
