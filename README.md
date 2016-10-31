# Vim yo.


## Prerequisites
This setup and short doc presumes you have existing Vim knowledge. This is
pretty serious overkill if you don't know the basics of Vim already. If you
don't have that knowledge, there are lots of resources you can find online. If
you already have knowledge, hopefully this will make you more productive with
Vim!

Also note, this is all currently running and tested with Vim 7.4. I'm not sure how
this configuration will behave with different versions.

You will want to make sure you have a 256 color terminal. Spacegray is a 256
color Vim theme and it will look awful otherwise.

## Install
Install the git submodules to get the Vim plugins.
```
git submodule update --init --recursive
```
My ~/.vimrc file is in vim/vimrc. Link that to the correct place.
```bash
ln -s vim/vimrc ~/.vimrc
```
My ~/.vim directory is in vim/dotvim. Link that to the correct place.
```bash
ln -s vim/dotvim ~/.vim
```

## Also install
You will also want to install ag (the_silver_searcher). How to do that will
depend on your platform. [Here is the github
repo](https://github.com/ggreer/the_silver_searcher). This is a vastly
superior grep/ack alternative. I use it in my vim config, as well as just an
alternative to grep/fgrep/ack.

You'll also need [fzf](https://github.com/junegunn/fzf).

For the syntax completion with YouCompleteMe, be sure to compile the plugin. `cd` into dotvim/bundle/YouCompleteMe and `./install.py`

## To update the plugins
To update your plugins down the road, run this again:
```
git submodule update --init --recursive
```
