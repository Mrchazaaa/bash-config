# Bash configuration

Personal Bash configuration, loaded through `init.sh`, which sources the tmux
and Neovim configuration files.

## Starting tmux

Run `starttmux` to create any missing sessions from `sessions.json` and focus the
first configured session. Pass an optional session name, such as
`starttmux "my-session"`, to focus that exact session if it exists after setup.
This also works for existing sessions outside the configuration. If no matching
session exists, the first configured session is focused as usual. Inside tmux,
the command switches the current client to the selected session.

## Installation

Run the installer with Bash (requires `curl` and `git`):

```bash
curl -fsSL https://raw.githubusercontent.com/Mrchazaaa/bash-config/master/install.sh | bash
```

This clones the repository into `~/.config/bash-config` and adds its loader to
`~/.bashrc`. Re-running the installer reuses an existing checkout without updating
it and avoids adding the same loader line twice. An unrelated directory at the
installation path is left untouched and causes the installer to stop.

Open a new Bash shell or run `source ~/.bashrc` to load the configuration.

You can also run `bash install.sh` from a local copy of the repository.

### Manual installation

1. Clone this repository into `~/.config/bash-config`:

   ```bash
   mkdir -p ~/.config
   git clone https://github.com/Mrchazaaa/bash-config.git ~/.config/bash-config
   ```

2. Open `~/.bashrc` in your preferred editor and add the following line at the end:

   ```bash
   source "$HOME/.config/bash-config/init.sh"
   ```

   Or append it with this one-liner:

   ```bash
   printf '\n%s\n' 'source "$HOME/.config/bash-config/init.sh"' >> ~/.bashrc
   ```

3. Reload your Bash configuration to apply the changes to your current shell:

   ```bash
   source ~/.bashrc
   ```

   New interactive Bash shells will load the configuration automatically.
