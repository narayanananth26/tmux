```bash
git clone https://github.com/narayanananth26/tmux.git ~/.config/tmux
```

### Symlink

```bash
ln -sf ~/.config/tmux/tmux.conf ~/.tmux.conf
```

or in `~/.tmux.conf`:

```bash
source-file ~/.config/tmux/tmux.conf
```

### Install TPM

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

then `prefix + I` to install plugins

### Tools

```bash
brew install fzf zoxide
```

or

```bash
sudo apt install fzf zoxide
```
