return {
	{ --cmp-nvim
		"hrsh7th/cmp-nvim-lsp",
	},
	{ --LuaSnip
		"L3M0N4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")

			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				}),
			})
			--Navigazione Dentro Lo Snippet
			vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
			vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
			vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
			vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})

			--Navigazione Dentro Lo Snippet
			vim.keymap.set({ "i" }, "<C-K>", function()
				ls.expand()
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-L>", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-H>", function()
				ls.jump(-1)
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-E>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })

			--Custom Snippets
			local function copyTemplate(file)
				local template = require(file)[1]
				local lines = vim.split(template, "\n", { plain = true })
				local buf = vim.api.nvim_get_current_buf()
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
				vim.lsp.buf.format()
			end

			vim.keymap.set("n", "<leader>esj",function() copyTemplate("snippets.eslint-react-js") end, { desc = "Template eslint for js and jsx" })
			vim.keymap.set("n", "<leader>est",function() copyTemplate("snippets.eslint-react-ts") end, { desc = "Template eslint for js and tsx" })
			vim.keymap.set("n", "<leader>ci", function () copyTemplate("snippets.cmake-c++") end, { desc = "CMake Initialize C++ Project" })
			vim.keymap.set("n", "<leader>cc", function () copyTemplate("snippets.cmake-c") end, { desc = "CMake Initialize C Project" })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})
		end,
	},
}
