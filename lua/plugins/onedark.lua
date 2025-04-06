-- onedark | github.com/navarasu/onedark.nvim?tab=readme-ov-file
return {
    'navarasu/onedark.nvim',
    name = 'onedark',
    config = function()
        require('onedark').setup{
            style = 'warmer'
        }
        require('onedark').load()
    end
}
