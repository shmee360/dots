# My Dotfiles

These will be quite disorganized for the time being, but hopefully they
will help me switch between computers more easily.

## Git
A program literally everyone needs. It has some basic authentication
and gpg stuff, but it's still a bit messy. I've gotten used to my
aliases.

The main security feature of this file is in the following code
snippet:

```
[include]
	path = key.gitconfig
```

Whenever I clone this repo, I need a separate file in the `git`
directory before I can `stow` the files, named `key.gitconfig`:

```
[user]
	signingkey = [id]
```

Here, `[id]` is the corresponding GPG key id for this computer on my
GitHub.

## Stack
I haven't quite figured this one out, but I can at least maybe save the config
file for Haskell Stack?

## Neovim
I've lovingly crafted this horrific mess of a vimrc for about two years on
and off, but now I'm beginning to like it.

Something to consider will be automatic plugin manager installation like
[this](https://github.com/LukeSmithxyz/voidrice/blob/master/.config/nvim/init.vim)

## TODO:
- [ ] neovim
	- [x] vimrc and basics
	- [x] Linux clipboard for non-WSL systems
		- [ ] ~~maybe automatic clipboard installation too?~~
			- this is actually quite stupid and doesn't need to be done
	- [ ] ~~automated ccls install~~
	- [ ] automated installer
- [ ] mpv
- [ ] bash
- [ ] xorg
- [ ] maybe some chromium stuff
- [ ] subtrees for my suckless forks (this will be really good to pull off)
