fish_config theme choose Dracula
set -g fish_autosuggestion_enabled 1
set -g fish_greeting ''

set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx RANGER_DEVICONS_SEPARATOR '  '

set -gx SUDO_EDITOR nvim
set -gx EDITOR nvim
set -gx VISUAL nvim

function fish_hybrid_key_bindings --description \
"Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
      fish_default_key_bindings -M $mode
    end
  fish_vi_key_bindings --no-erase
end
set -g fish_key_bindings fish_hybrid_key_bindings

function fish_user_key_bindings
  # Execute this once per mode that emacs bindings should be used in
  fish_default_key_bindings -M insert

  # Then execute the vi-bindings so they take precedence when there's a conflict.
  # Without --no-erase fish_vi_key_bindings will default to
  # resetting all bindings.
  # The argument specifies the initial mode (insert, "default" or visual).
  fish_vi_key_bindings --no-erase insert
end

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert underscore
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one block
set fish_cursor_replace block
# Set the external cursor to a line. The external cursor appears when a command is started.
# The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
set fish_cursor_external line
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block

### Plugins ###
## FZF
set -U fzf_preview_dir_cmd eza --all --color=always
set -U fzf_preview_file_cmd bat -n
set -U fzf_fd_opts --hidden --max-depth 5
set -U fzf_git_log_format "%H %s"
# width=20 so delta decorations don't wrap around small fzf preview pane
#set fzf_diff_highlighter delta --paging=never --width=20
# Or, if using DFS
set -U fzf_diff_highlighter diff-so-fancy
set -U fzf_history_time_format %d-%m-%y

## NVM
set --universal nvm_default_version lts/krypton
set --universal nvm_default_packages yarn np
set --global nvm_data $XDG_DATA_HOME/nvm

## Spoonge
set -U sponge_successful_exit_codes 0 127
set -U sponge_allow_previously_successful true
set -U sponge_regex_patterns '(?:\d{1,3}\.){3}\d{1,3}'
set -U sponge_delay 1
set -U sponge_purge_only_on_exit false

## ProjectDo
abbr -a b --function projectdo_build
abbr -a r --function projectdo_run
abbr -a t --function projectdo_test
abbr -a p --function projectdo_tool

alias t='projectdo test'
alias r='projectdo run'
alias b='projectdo build'
alias p='projectdo tool'

## Abbreviation
set -U ABBR_TIPS_PROMPT "\n󰛩 \e[1m{{ .abbr }}\e[0m => {{ .cmd }}"
set -U ABBR_TIPS_ALIAS_WHITELIST # Not set
set -U ABBR_TIPS_REGEXES '(^(\w+\s+)+(-{1,2})\w+)(\s\S+)' '(^( ?\w+){3}).*' '(^( ?\w+){2}).*' '(^( ?\w+){1}).*'
# 1 : Test command with arguments removed
# 2 : Test the firsts three words
# 3 : Test the firsts two words
# 4 : Test the first word

### Abbreviation & Alias ###
## Abbreviation
# Pacman Functions
abbr -a spsy 'sudo pacman -Sy'
abbr -a spsu 'sudo pacman -Su'
abbr -a spsyy 'sudo pacman -Syy'
abbr -a spsuu 'sudo pacman -Suu'
abbr -a spsyyu 'sudo pacman -Syyu'
abbr -a spsyyuu 'sudo pacman -Syyuu'

## Alias
# List Directories
alias ls 'eza --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first'
alias la 'eza --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --almost-all'
alias lls 'eza --long --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --group --smart-group --header --total-size --octal-permissions'
alias lla 'eza --long --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --almost-all --group --smart-group --header --total-size --octal-permissions'
# List Directories With Git
alias lsg 'eza --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --git-ignore --git --git-repos-no-status'
alias lag 'eza --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --almost-all --git-ignore --git --git-repos-no-status'
alias llsg 'eza --long --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --git-ignore --group --smart-group --header --total-size --octal-permissions --git --git-repos-no-status'
alias llag 'eza --long --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --git-ignore --almost-all --group --smart-group --header --total-size --octal-permissions --git --git-repos-no-status'
# List Directories (Tree Mode)
alias lst 'eza --tree --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first'
alias lat 'eza --tree --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --almost-all'
alias llst 'eza --long --tree --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --group --smart-group --header --total-size --octal-permissions'
alias llat 'eza --long --tree --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --almost-all --group --smart-group --header --total-size --octal-permissions'
# List Directories With Git (Tree Mode)
alias lstg 'eza --tree --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --git-ignore --git --git-repos-no-status'
alias latg 'eza --tree --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --almost-all --git-ignore --git --git-repos-no-status'
alias llstg 'eza --long --tree --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --git-ignore --group --smart-group --header --total-size --octal-permissions --git --git-repos-no-status'
alias llatg 'eza --long --tree --color always  --color-scale all --colour-scale-mode fixed --icons always --group-directories-first --git-ignore --almost-all --group --smart-group --header --total-size --octal-permissions --git --git-repos-no-status'

alias grep="rg"
alias find="fd"

# Export FZF Default Options (agar fzf pakai Ripgrep/fd)
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx FZF_DEFAULT_OPTS '--height 100% --layout=reverse --border --info=inline'

# Created by `pipx` on 2025-02-08 14:11:32
set PATH $PATH /home/kresna/.local/bin

function abbr_update_keys_and_values
  __abbr_tips_init
end

abbr_update_keys_and_values

starship init fish | source
zoxide init --cmd cd fish | source
fzf --fish | source
