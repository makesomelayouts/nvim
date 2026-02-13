# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

# To make plugins work

## Any OS
Install [nerd font](https://www.nerdfonts.com) 

For MarkdownTemplate
```bash
npm i -g yarn
```

Install manually
```bash
:call mkdp#util#install()
```

## Windows version (w/o WSL)
Better to use windows version rather than WSL, because otherwise file cant lose focus when you alt+tab and then he will not be saved, but maybe you don't need that, just an option that I need.

to make [windows terminal](https://github.com/microsoft/terminal) create a new tab instead of new app, add
```json
    "windowingBehavior": "useExisting",
```
in json config.

Nerdfonts: For nvim-qt add in init.lua

Make treesitter work
```bash
winget install --id=BrechtSanders.WinLibs.POSIX.UCRT -e
```

3.12
```bash
winget install Python.Python.3.12
```

```bash
winget install -e --id 7zip.7zip
```

Install Treesitter
```
npm install -g tree-sitter-cli
```
or
```
choco install tree-sitter -y
```

Install repgrip and fd
```bash
npm install -g ripgrep fd-find fzf
```
```
```
or
```bash
choco install ripgrep fd fzf -y
```
```
```

