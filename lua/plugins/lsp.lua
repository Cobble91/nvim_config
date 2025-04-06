return {
  {
    'williamboman/mason.nvim'
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason").setup()
    end,
    lazy = false,
    opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
        "rust_analyzer",
        "pyright",
        "superhtml",
        "cssls",
        "ts_ls",
        "java_language_server",
        "texlab"
      },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,
      },
      automatic_installation = true
    },

  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Reserve a space in the gutter
      -- vim.opt.signcolumn = 'yes'

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      local lspconfig_defaults = require('lspconfig').util.default_config
      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lspconfig_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- This is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf}

          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', '<leader>vws', '<cmd>lua vim.lsp.buf.workspace_symbol<cr>', opts)
          vim.keymap.set('n', '<leader>vd', '<cmd>lua vim.lsp.buf.open_float()<cr>', opts)
          vim.keymap.set('n', '[d', '<cmd>lua vim.lsp.buf.goto_next()<cr>', opts)
          vim.keymap.set('n', ']d', '<cmd>lua vim.lsp.buf.goto_prev()<cr>', opts)
          vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
          vim.keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', '<leader>rn', '<cmd>luavim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        end,
      })

      -- These are just examples. Replace them with the language
      -- servers you have installed in your system
      require('lspconfig').lua_ls.setup({})
      require('lspconfig').clangd.setup({})
      require('lspconfig').rust_analyzer.setup({})
      require('lspconfig').pyright.setup({})
      require('lspconfig').superhtml.setup({})
      require('lspconfig').cssls.setup({})
      require('lspconfig').ts_ls.setup({})
      require('lspconfig').java_language_server.setup({})
      require('lspconfig').texlab.setup({})

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      })

      local cmp = require('cmp')

      cmp.setup({
        sources = {
          {name = 'nvim_lsp'},
        },
        snippet = {
          expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({}),
      })
    end,
  },
  {'hrsh7th/cmp-nvim-lsp'},
  {'L3MON4D3/LuaSnip'},
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        -- preselect first item
        preselect = 'item',
        completion = {
          autocomplete = false,
          completeopt = 'menu,menuone,noinsert'
        },
        -- keybinds
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- enter to select
          ['<CR>'] = cmp.mapping.confirm({select = false}),
          -- ^space to open menu
          ['<C-Space>'] = cmp.mapping.complete(),
          -- Super tab
          ['<Tab>'] = cmp.mapping(function(fallback)
            local luasnip = require('luasnip')
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
              cmp.select_next_item({behavior = 'select'})
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
              fallback()
            else
              cmp.complete()
            end
          end, {'i', 's'}),

          -- Super shift tab
          ['<S-tab>'] = cmp.mapping(function(fallback)
            local luasnip = require('luasnip')

            if cmp.visible() then
              cmp.select_prev_item({behavior = 'select'})
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {'i', 's'}),
        }),
        --[[window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        }]] -- it looks weird
      })
    end,
  },
}
