# 💤 [LazyVim](https://github.com/LazyVim/LazyVim)

Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

$$\LARGE\textsf{\textbf{To make plugins work}}$$

## Any OS

$$\Large\textsf{\textbf{Icons}}$$

Install [nerd font](https://www.nerdfonts.com) (for icons and mono font) <br>(personally I use `CaskaydiaCove Nerd Font Mono` as you can see in `init.lua` file)

$$\Large\textsf{\textbf{Markdown preview}}$$

```bash
npm i -g yarn
```

or install manually in neovim

```bash
:call mkdp#util#install()
```

## Windows version (without WSL)

> [!TIP]
> Consider using the native Windows version instead of WSL. In WSL, the file may not lose focus when you Alt+Tab, which can prevent autosaving. If you need seamless autosave on window switch, the Windows build is the preferred option.

$$\Large\textsf{\textbf{Install needed dependencies}}$$

run `cmd.exe` with **admin** rights:

```
choco install tree-sitter ripgrep fd fzf lazygit -y
```

or

```
npm install -g tree-sitter-cli ripgrep fd-find fzf lazygit
```

$$\Large\textsf{\textbf{Windows Terminal tabs}}$$

to make [windows terminal](https://github.com/microsoft/terminal) create a new tab instead of new app, add

```json
    "windowingBehavior": "useExisting",
```

in json config.

$$\Large\textsf{\textbf{Nvim-qt}}$$

Nerdfonts: For nvim-qt add in `init.lua`

```bash
winget install BrechtSanders.WinLibs.POSIX.UCRT Python.Python.3.12 7zip.7zip
```
