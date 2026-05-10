return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")
--TODO
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    todo_comments.setup({
      keywords = {
        FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "hack" },
        WARN = { icon = " ", color = "warning",  alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", color = "perf",     alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint",     alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test",   alt = { "TESTING", "PASSED", "FAILED" } },
      },
      colors = {
        error   = { "#c86a5a" },
        warning = { "#c8a84a" },
        info    = { "#e8c46a" },
        hint    = { "#7ec8a0" },
        hack    = { "#c8956c" },
        perf    = { "#7db5c8" },
        test    = { "#9a7ab8" },
      },
    })
  end,
}
