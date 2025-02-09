local Terminal = require('toggleterm.terminal').Terminal

-- Helper function to check if ipython is available
local function check_ipython()
    local handle = io.popen("which ipython 2>/dev/null")
    if handle then
        local result = handle:read("*a")
        handle:close()
        return result ~= ""
    end
    return false
end

-- Helper function to show error message
local function show_error_message()
    vim.api.nvim_err_writeln("Error: IPython is not available in your environment.\n" ..
                            "Please install IPython or activate your virtual environment.")
end

function _window_toggle(window)
    -- Special handling for interactive window
    if window == interactive_window and not check_ipython() then
        show_error_message()
        return
    end
    
    window:toggle()
    -- change to insert mode when toggling
    if window:is_open() then
        window:set_mode("i")
    end
end

-- Float Window --
local float_window = Terminal:new({
    direction = "float",
    float_opts = {
        border = "double",
        size = 40,
    },
    close_on_exit = true,
})

vim.keymap.set("n", "<A-i>", function() _window_toggle(float_window) end, { noremap = true, silent = true })
vim.keymap.set("t", "<A-i>", function() _window_toggle(float_window) end, { noremap = true, silent = true })

-- Vertical Window --
local vertical_window = Terminal:new({
    direction = "vertical",
    close_on_exit = true,
})
vertical_window:resize(30)
vim.keymap.set("n", "<A-v>", function() _window_toggle(vertical_window) end, { noremap = true, silent = true })
vim.keymap.set("t", "<A-v>", function() _window_toggle(vertical_window) end, { noremap = true, silent = true })

-- Horizontal Window --
local horizontal_window = Terminal:new({
    direction = "horizontal",
    close_on_exit = true,
})

vim.keymap.set("n", "<A-h>", function() _window_toggle(horizontal_window) end, { noremap = true, silent = true })
vim.keymap.set("t", "<A-h>", function() _window_toggle(horizontal_window) end, { noremap = true, silent = true })

-- Lazy Git --
local lazygit = Terminal:new({
    display_name = "Lazy Git",
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
        border = "double",
        title_pos = "center"
    },
})

vim.keymap.set("n", "<A-g>", function() _window_toggle(lazygit) end, { noremap = true, silent = true })
vim.keymap.set("t", "<A-g>", function() _window_toggle(lazygit) end, { noremap = true, silent = true })

-- Interactive Window --
local interactive_window
if check_ipython() then
    interactive_window = Terminal:new({
        cmd = "ipython --autoindent",
        display_name = "Interactive Window",
        direction = "vertical",
        size = function()
            return vim.o.columns * 0.5
        end,
        on_open = function(term)
            term:resize(vim.o.columns * 0.5)
        end
    })
end

vim.keymap.set("n", "<A-p>", function() _window_toggle(interactive_window) end, { noremap = true, silent = true })
vim.keymap.set("t", "<A-p>", function() _window_toggle(interactive_window) end, { noremap = true, silent = true })

