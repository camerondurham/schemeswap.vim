# schemeswap.vim

I like macOS automatic theme switching. I couldn't find another plugin to do
the same for Vim/NeoVim so I wrote this.

[![asciicast](https://asciinema.org/a/9GlYlFWGksP3y1iynhpEmbLZv.svg)](https://asciinema.org/a/9GlYlFWGksP3y1iynhpEmbLZv)

There are definitely many smarter ways to do this, I'm sure, but I don't know
them yet.

Feel free to give some suggestions on how to improve this ~~yell how dumb this
is~~ in the GitHub issues :)

## Features

Use `:BG` to toggle between dark and light colorschemes.
Unfortunately this only affects your current session for now.

See the `:help` for details.

## Configuration

You should probably remove any `colorscheme` settings you have in your
`init.vim` or `.vimrc`.

### Defaults

- Daytime: `07:30`
- Nighttime: `17:00`
- Daytime colorscheme: `morning`
- Nighttime colorscheme: `default`


### Example Config

```viml
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SCHEMESWAP:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:schemeswap_nighttime = '17:00'
let g:schemeswap_daytime = '07:30'


" set dark and light colorschemes
let g:dark_colorscheme = 'spacecamp'     " defaults to 'default'
let g:light_colorscheme = 'PaperColor'   " defaults to 'morning'

" optional custom functions to call

" this function will be called when the theme is toggled
function CustomDarkSettings()
  let g:material_theme_style = 'darker'

  " custom setting from lightline.vim (*really* great plugin btw!)
  " change the lightline colorscheme when you change the background
  let g:lightline = {
        \ 'colorscheme' : 'powerline',
        \ }
endfunction

function CustomLightSettings()
  let g:material_theme_style = 'lighter'
  let g:lightline = {
        \ 'colorscheme' : 'PaperColor',
        \ }
endfunction
```

## Installation

Plugged

```viml
Plug 'camerondurham/schemeswap.vim'
```

## Todo

- [ ] explain custom dark/light theme functions
- [ ] implement automatic sunset/sunrise calculation?
- [ ] actually write help docs

