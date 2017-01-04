# Vim Arduino

This script is based on [Vim Arduino][vim-arduino], but uses the
Arduino command line utility instead of the ino/ano compiler.
It allows for compiling and deployment of Arduino (\*.pde/\*.ino) 
sketches directly from Vim.

## Install

The plugin is structured for use with [Pathogen][pathogen] so installation
should be easy, assuming you have Pathogen installed.

## Requirements
[Arduino IDE][arduino] must be installed on your computer for this plugin to work (Previously, [Ano][ano]/[Ino][ino-project] was used, but that repo is not compatible with newer Arduino IDE versions).

## Usage
Vim Arduino can be run using the following keys:

`<Leader>ac` - Compile the current sketch.

`<Leader>ad` - Compile and deploy the current sketch.

`<Leader>as` - Open a serial port in `screen`.

## Options
The default key mapping can be turned off by doing this in your `.vimrc`:

```
let g:vim_arduino_map_keys = 0
```

To open the serial monitor automatically after each deploy,
add this to your `.vimrc`:

```
let g:vim_arduino_auto_open_serial = 1
```

To change the command used to build and deploy :

```
let g:vim_arduino_cmd = 'arduino'
```

To change the port used to deploy :

```
let g:vim_arduino_port = 'ttyUSB0'
```

To change the board used to compile and deploy :

```
let g:vim_arduino_board = 'arduino:avr:leonardo'
```


[pathogen]: http://www.vim.org/scripts/script.php?script_id=2332
[ano]: https://github.com/scottdarch/Arturo
[vim-arduino]: https://github.com/tclem/vim-arduino
[arduino]: http://arduino.cc/en/Main/Software
[ino-project]: http://inotool.org/quickstart
