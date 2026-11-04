# Bash configuration

Personal Bash configuration, loaded through `init.sh`, which sources the tmux
and Neovim configuration files.

## Installation

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
