# simple-session-vim
preserve the simplest session in vim.

## Functionality

save opened files in `.session.vim` by default, and next time vim starts up, all these files
will be reopened automatically.

## Installations

this repo requires vim with python support compiled. to check that:

    $ vim --version | grep python

you shall see `+python` somewhere in the output.

for `pathogen` users, in `~/.vim/bundle` folder:

    $ git clone https://github.com/HuStmpHrrr/pythonutils-vim

then put `.vimrc` in this repo in your project folder, and put `set exrc` in `~/.vimrc`.

one may consider put `set secure` too. for further reading: `:h secure`.

you may also want `.vimrc` to be ignored by git, you can:

    $ git config --global core.excludesfile ~/.gitignore_global
    $ echo .vimrc >> ~/.gitignore_global

## Why?

I tried two session managers before, which are vim builtin `:mksession`, and [vim-session](https://github.com/xolox/vim-session).

they are good, but don't match my requirement. in my `~/.vimrc`, i configured in a way such that nerdtree and taglist
show up automatically and a lot of key bindings, settings, etc.

since all settings go into `~/.vim` and `~/.vimrc`, I don't really need these session manager to 
keep track of the settings I will run every time I start up a new vim instance, but just remember
what files I opened up and just reopen them next time I start vim.

on top of that, these two managers screwed up the layout of windows as well as syntax highlight.

so, for me, an easy peasy script satisfies all my requirements.
