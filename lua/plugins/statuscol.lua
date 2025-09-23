return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      segments = {
        {
          sign = {
            name = { ".*" }, -- match su tutti i segniname
            text = { ".*" },
            namespace = { ".*" },
            maxwidth = 1,  -- massimo 1 segno visibile
            colwidth = 1,  -- larghezza della colonna
            auto = false,  -- cosa mostrare se non ci sono segni
            fillchar = " ", -- carattere di riempimento
            wrap = false,  -- mostrare anche su linee virtuali
          },
          click = "v:lua.ScSa", -- funzione di click
          hl = "SignColumn", -- highlight
        },
        {
          text = { builtin.lnumfunc, " " },
          condition = { true, builtin.not_empty },
          click = "v:lua.ScLa",
        },
        { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
      },
    })
  end,
}
