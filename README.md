# calabi-shell

A minimal Bash + Starship prompt setup for the [calabi project](https://gprocunier.github.io/calabi/).

This work is based on the general approach of Chris Titus Tech's [mybash](https://github.com/ChrisTitusTech/mybash), but intentionally stripped down and adapted for calabi-specific prompt behavior, including the Kerberos session banner.

## Supported platforms

`calabi-shell` intentionally supports only:

- RHEL 10+
- Fedora 43+

The installer enforces this in code by checking `/etc/os-release` and refusing to run on other operating systems or older releases.

## What it does

- Installs Starship if it is missing
- Installs a dedicated Starship config
- Adds a small managed Bash init block instead of replacing your whole shell config
- Shows a Kerberos banner only when a valid Kerberos ticket cache exists
- Keeps the primary prompt intentionally small: `user@host`, directory, and time

## Modes

### Per-user mode

Default behavior:

- Installs Starship to `~/.local/bin` if it is missing
- Installs config to `~/.config/calabi-shell/starship.toml`
- Adds a managed block to `~/.bashrc`

### System mode

`./install.sh --system` requires root and installs:

- Starship to `/usr/local/bin` if it is missing
- Config to `/etc/xdg/calabi-shell/starship.toml`
- A managed environment snippet at `/etc/profile.d/calabi-shell.sh`
- A managed Bash init block in `/etc/bashrc`

## What it does not do

- Does not replace your entire `~/.bashrc` or `/etc/bashrc`
- Does not install Chris Titus Tech aliases, helper functions, `fzf`, `zoxide`, `fastfetch`, `neovim`, or font packages
- Does not remove an existing Starship installation during uninstall

## Install

```bash
chmod +x ./install.sh
./install.sh
exec bash -l
```

## Install system-wide

```bash
sudo ./install.sh --system
exec bash -l
```

## Uninstall

```bash
chmod +x ./uninstall.sh
./uninstall.sh
exec bash -l
```

## Uninstall system-wide

```bash
sudo ./uninstall.sh --system
exec bash -l
```

## Notes

This prompt uses Nerd Font glyphs. If the separators render incorrectly, configure a Nerd Font in your terminal.

## Shell Output Example
[](./calabi-shell.png)
