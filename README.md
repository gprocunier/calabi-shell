# calabi-shell

A minimal Bash + Starship prompt setup for the [calabi project](https://gprocunier.github.io/calabi/).

This work is based on the general approach of Chris Titus Tech's [mybash](https://github.com/ChrisTitusTech/mybash), but intentionally stripped down and adapted for calabi-specific prompt behavior, including the Kerberos session banner.

## Supported platforms

`calabi-shell` intentionally supports only:

- RHEL 10+
- Fedora 43+

The installer enforces this by checking `/etc/os-release` and refusing to run on unsupported platforms. Use `--force` to bypass this check on other distributions — this is not validated and may require manual adjustments.

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

## Install on unsupported platforms

```bash
./install.sh --force
# or
sudo ./install.sh --system --force
```

The `--force` flag bypasses the distribution check. A warning is logged but installation proceeds. This is not validated — Starship and Nerd Fonts should work on most Linux distributions, but the managed block format and profile paths may need adjustment.

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
![Calabi Shell](https://github.com/gprocunier/calabi-shell/blob/main/calabi-shell.png)
*a user without a kerberos session ticket tries to log in via krb sso as sysop to idm-01 and fails. They then get a session ticket from the domain for sysop@WORKSHOP.LAN and are able to sso in.  the before ticket and after ticket is visualized in the shell aesthetically, but the real thing is that krb/gss sso is a thing*
