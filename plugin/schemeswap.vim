" schemeswap.vim - really basic plugin to set scheme depending on the time
" Maintainer:   cam <https://u64.cam/>
" Version:      1.0
" ------------------

" TODO: how to idiomatically declare variable?
let g:schemeswap_theme = ''

" TODO: figure out how to calculate sunset/sunrise either maybe using an
" Operating System setting/API if it exists, trying to call an API (*not
" a good idea*), or manually calculating it with physics equations?
"
function! CurrentTime()
  return strftime('%H:%M')
endfunction

" Currently not used.
"
" Maybe would be useful if I have a lookup table of
" sunset/sunrise times at UTC and can use this offset to figure out when to
" change colorschemes.
function! CurrentUtcOffset()
  return strftime('+%z')
endfunction

function! s:get_dark_colorscheme()
  if !exists('g:dark_colorscheme')
    return 'default'
  else
    return g:dark_colorscheme
  endif
endfunction

function! s:get_light_colorscheme()
  if !exists('g:light_colorscheme')
    return 'morning'
  else
    return g:light_colorscheme
  endif
endfunction

function! s:darktheme()
  set background=dark
  let g:schemeswap_theme = 'dark'
  execute 'colorscheme' s:get_dark_colorscheme()
  if exists("*CustomDarkSettings") == 1
    call CustomDarkSettings()
  endif
endfunction

function! s:lighttheme()

  set background=light
  let g:schemeswap_theme = 'light'
  execute 'colorscheme' s:get_light_colorscheme()

  " TODO: is this needed?
  redraw

  if exists("*CustomLightSettings") == 1
    call CustomLightSettings()
  endif
endfunction


function! s:nighttime()
  if !exists('g:schemeswap_nighttime')
    return '17:00'
  else
    return g:schemeswap_nighttime
  endif
endfunction

function! s:daytime()
  if !exists('g:schemeswap_daytime')
    return '07:30'
  else
    return g:schemeswap_daytime
  endif
endfunction

function! s:setscheme(theme)
  " TODO: implement setting scheme
  if a:theme == "dark"
    call s:darktheme()
  elseif a:theme == "light"
    call s:lighttheme()
  endif

  " update graphics plugins if they're loaded
  " TODO: add defaults for other popular plugins, if they have similar init
  " and update functions that should be called
  if exists("*lightline#init") == 1
    call lightline#init()
  endif

  if exists("*lightline#update") == 1
    call lightline#update()
  endif
endfunction


if exists("*togglebg") == 0
  function s:togglebg()

    " toggle brackground
    if g:schemeswap_theme == 'dark'
      call s:setscheme('light')
    elseif g:schemeswap_theme == 'light'
      call s:setscheme('dark')
    endif

    call lightline#init()
    call lightline#update()
  endfunction

  " call with :BG
  command BG call s:togglebg()
endif

function! SetBackground()
  " set dark background (or really whatever theme you want)
  " if it's after g:scheschemeswap_nighttime

  if CurrentTime() >= s:nighttime() || CurrentTime() <= s:daytime()

    " check if background is explicitly set to light
    " this will happen if user runs `:BG` or manually sets it
    " we don't want to update colorscheme if user has manually toggled it to
    " light theme
    if g:schemeswap_theme != 'light'
      call s:setscheme('dark')
    endif
  else

    " check if background is explicitly set to dark
    if g:schemeswap_theme != 'dark'
      call s:setscheme('light')
    endif
  endif
endfunction

" TODO: can this not refresh so frequently? Very unlikely we need to refresh
" this every CursorHold event since that happens every few seconds. See if
" this can just be refreshed every few minuetes.
" check :help autocmd-events for other related events this could hook onto
autocmd CursorHold * call Timer()
function! Timer()
  call SetBackground()
endfunction

" :help autocmd-events for more
autocmd VimEnter * :call SetBackground()

