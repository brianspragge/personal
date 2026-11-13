# Personal

Personal setup and configs, organized per system.

## Arch (standalone)

Bare Arch Linux with Hyprland, using only standard Arch tooling. It mirrors the
personal Omarchy setup where practical, but has no Omarchy dependency: no
`/usr/share/omarchy`, `omarchy-launch-*`, `omarchy-shell`, or Omarchy theme
files.

1. Clone the repo:

   ```bash
   git clone git@github.com:brianspragge/personal.git ~/Repos/personal
   ```

2. Run the setup script as your normal user:

   ```bash
   ~/Repos/personal/arch/dev/setup/install.sh
   ```

   Options:

   - `--config-only` — link configs without installing packages or services.
   - `--no-packages` — skip package installation; still configure services.
   - `--tags` — regenerate Vim ctags for C++, Python, Go, and Rust.

   Existing regular files are backed up before being replaced by symlinks.
   Personal `.desktop` launchers are copied with paths adjusted for `$HOME`.

3. Add the vimium options into Chromium and Zen Browser respectively (see
   `vimium/`).

## Omarchy (Arch)

1. Clone the repo:

   ```bash
   git clone git@github.com:brianspragge/personal.git ~/Repos/personal
   ```

2. Run the setup script:

   ```bash
   ~/Repos/personal/omarchy/dev/setup/install.sh
   ```

   It diffs each personal config against what is installed and asks whether
   to copy it. Nothing is overwritten without confirmation.

3. Add the vimium options into chromium and zen-browser respectively (see `vimium/`).

## Other systems

- `fedora/` — see `README-Fedora.md`
