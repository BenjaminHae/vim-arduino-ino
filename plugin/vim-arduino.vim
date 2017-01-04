let s:vim_arduino_version = '0.2.0'

" Load Once: {{{1
if exists("loaded_vim_arduino")
    finish
endif
let loaded_vim_arduino = 1

if !exists('g:vim_arduino_auto_open_serial')
  let g:vim_arduino_auto_open_serial = 0
endif

if !exists('g:vim_arduino_port')
  let g:vim_arduino_port = "ttyUSB0"
endif

if !exists('g:vim_arduino_cmd')
  let g:vim_arduino_cmd = 'arduino'
endif

let s:helper_dir = expand("<sfile>:h")

function! s:PrintStatus(result)
  if a:result == 0
    echohl Statement | echomsg "Succeeded." | echohl None
  else
    echohl WarningMsg | echomsg "Failed." | echohl None
  endif
endfunction

" Private: Compile or deploy code
"
" Returns nothing.
function! s:InvokeArduinoCli(deploy)
  call s:ArduinoKillMonitor()
  let l:flag = a:deploy ? "-d" : "-c"
  let l:f_name = expand('%:p')
	  let l:board = ""
  if exists('g:vim_arduino_board')
	  let l:board = " --board " . g:vim_arduino_board
  endif
  execute "w"
  if a:deploy
    echomsg "Compiling and deploying..." l:f_name
    let l:result = system(g:vim_arduino_cmd . " --upload " . l:f_name . " --port " . g:vim_arduino_port . l:board)
  else
    echomsg "Compiling..." l:f_name
    let l:result = system(g:vim_arduino_cmd . " --verify " . l:f_name . l:board)
  endif

  echo l:result
  call s:PrintStatus(v:shell_error)

  return !v:shell_error
endfunction

" Private: Release the /dev/tty.usb* port so we can recompile
"
" Returns nothing.
function! s:ArduinoKillMonitor()
  let output = system("screen -X -S arduino-serial quit")
endfunction

" Public: Compile the current pde file.
"
" Returns nothing.
function! ArduinoCompile()
  call s:InvokeArduinoCli(0)
endfunction

" Public: Compile and Deploy the current pde file.
"
" Returns nothing.
function! ArduinoDeploy()
  call s:InvokeArduinoCli(1)

  " optionally auto open a serial port
  if g:vim_arduino_auto_open_serial
    call ArduinoSerialMonitor()
  endif
endfunction

" Public: Monitor a serial port
"
" Returns nothing.
function! ArduinoSerialMonitor()
  echo system(s:helper_dir."/vim-arduino-serial")
endfunction

if !exists('g:vim_arduino_map_keys')
  let g:vim_arduino_map_keys = 1
endif

if g:vim_arduino_map_keys
  nnoremap <leader>ac :call ArduinoCompile()<CR>
  nnoremap <leader>ad :call ArduinoDeploy()<CR>
  nnoremap <leader>as :call ArduinoSerialMonitor()<CR>
endif
