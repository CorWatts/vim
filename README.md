# Corey's Vim Setup

I know you all are just dying to hear about my Vim setup. Finally my incessant
evangelizing has broken through. Wait no longer.

## Prerequisites
This setup and short doc presumes you have existing Vim knowledge. This is
pretty serious overkill if you don't know the basics of Vim already. If you
don't have that knowledge, there are lots of resources you can find online. If
you already have knowledge, hopefully this will make you more productive with
Vim!

Also note, I'm running Arch Linux, so I've got the bleeding edge version of
Vim (this is all currently running and tested with Vim 7.4). I'm not sure how
this configuration will behave with older versions.

You will want to make sure you have a 256 color terminal. Spacegray is a 256
color Vim theme and it will look awful otherwise.

## Steps
Install the git submodules to get the Vim plugins.
```
git submodule init
git submodule update
```
My ~/.vimrc file is in /vim/vimrc. Link that to the correct place.
```bash
ln -s ~/.vimrc vim/vimrc
```
My ~/.vim directory is in /vim/dotvim. Link that to the correct place.
```bash
ln -s ~/.vim vim/dotvim
```

## Also install
You will also want to install ag (the_silver_searcher). How to do that will
depend on your platform. [Here is the github
repo](https://github.com/ggreer/the_silver_searcher). This is a vastly
superior grep/ack alternative. I use it in my vim config, as well as just an
alternative to grep/fgrep/ack.

## Opening files
There are two plugins I have configured to deal with finding and opening
files. NERDTree and CtrlP. Please please please check out their documentation
yourself, this covers the absolute basic usage of them.

### NERDTree
Open NERDTree by hitting `ctrl-n`, close it again with that same shortcut. You
can use regular Vim movement commands to navigate around the file tree.Press
`o` to open the selected file in the main window or press `o` on the (up a
dir) item to move up a directory. Helpful tips are:  
  - t: Open the selected file in a new tab  
  - i: Open the selected file in a horizontal split window  
  - s: Open the selected file in a vertical split window
 
### CtrlP
CtrlP is my go-to file finder, however. To open it, simply press `ctrl-p`.
That will open a section on the bottom of your terminal. Type in a filename,
or a piece of a filepath, and several matches will be presented to you. Once
you find the file you want, press `ctrl-t`, `ctrl-v`, or `ctrl-x` to open it
up in a tab or split.  
  - This is one of the uses of the `ag` program. The CtrlP typeahead uses grep
    under the hood by defaultm, which is slow on our codebase. Ag is still
quite fast. If you dig into the vimrc, you'll see I've disabled the CtrlP
cache too. It just isn't necessary with how fast ag is.
  
## Syntax Checking
Syntax checking is done on every save, automatically. If there is a syntax
error, the plugin Syntastic will open a box at the bottom with the error and
line number. This should work pretty well out of the box for the necessary
languages in our codebase. Fix the error, save it again, and the box should
disappear.

## Quick Scope
Quick Scope is a fantastic plugin. It allows very easy motion across a line.
I've hotkeyed it to `f`. In command mode, just press `f` and you will see
various characters highlighted across the line. Press that character to jump
to that spot. Way easier than pressing `eee` or having to estimate and press
`4e` and get it wrong.

## Rainbow Parentheses
Nifty little plugin. It colors matching parentheses/brackets/braces different
colors. Helps to quickly eyeball which parentheses belong to which when you're
in a huge nested mess.

## vim-css-color
Another nifty plugin. If you're working with specified colros (RGB/Hex) and
you have the specific Hex code in a CSS/SASS file, this plugin will highlight
that block in the respective color. This makes it VERY nice to immediately see
which colors you're using.

## Special Custom Ag Functions
I've hotkeyed `K` to have some cool functionality, thanks to Ag. Hover over
any word in a file, and press `K`. That will search the whole codebase and
return all the occurrences of the search term. Select the file you like, and
press `[enter]`.

I've also hotkeyed the `\` key to be a quick search.Just press it, then type
in `[path] '[search term]'`. That will bring up a bunch of matches. Select the
one you want, and press `[enter]`.

## NERDCommenter
There is also a fancy comment plugin. The leader key is set to `,`. So
highlight some block using Visual mode, then press `,cs` to comment out each
line. There are a ton of different ways to commment that this plugin supports,
check out the documentation.

## Vim Surround
This is a super cool plugin that allows you to chage "surrounding" text. This gets complex fast, but a simple example is: assume you have `"Hello world!"` somewhere in your code. You can put the cursor anywhere in that string and type `cs"'` to change it to `'Hello world!'`. Don't worry, this works with braces, brackets, even HTML tags. And it keeps getting deeper. Check out the documentation for this plugin to see.
