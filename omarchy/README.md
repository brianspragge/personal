# Omarchy

Personal Omarchy configuration files for Hyprland, vim, bash, and application launchers.

## Structure

- `dev/setup/install.sh` - Interactive installer
- `dev/user/` - Config files that get copied into `$HOME`

## Install

```bash
cd omarchy/dev/setup
./install.sh
```

The script interactively copies each config file into your home directory, showing diffs for any existing files. `.desktop` launchers have hardcoded `/home/bms` paths — if your home differs from `/home/bms`, you'll be prompted to rewrite them to `$HOME`.

## What gets installed

- `.bashrc`, `.inputrc`, `.vimrc`
- Hyprland configs (`~/.config/hypr/*.lua`)
- Scripts (`~/.local/bin/`)
- Vim thesaurus
- Application launchers (`~/.local/share/applications/`)
- GPG/coscope scripts
- vim ctags (optional)
- Git signing config
