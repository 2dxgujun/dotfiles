# My dotfiles

### Install

Clone this repo into `~/.dotfiles`:
```
git clone git@github.com:2dxgujun/dotfiles.git ~/.dotfiles
```

Install [jake](https://github.com/jakejs/jake):
```
npm install -g jake
```

Install dependencies:
```
cd ~/.dotfiles
npm install
```

Then install the dotfiles:
```
jake
```

This jake task will ask you replace existing files, it will replace the existing symlinks.

The dotfiles will be symlinked, e.g. `~/.zshrc` symlinked to `~/.dotfiles/zshrc`.

Don't forget to **replace the name and email in gitconfig** if you're not Jun Gu :p. You should replace `zshrc` file to your own `.zshrc` file since it's personalized.

**WARNING**: Be careful of replace existing files, you should backup your dotfiles before install the dotfiles.

### Vim

Install plugins from submodules:

```
git submodule update --init
```
