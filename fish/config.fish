if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -qU HYPRSHOT_DIR ~/desktop/screenshots/
source ~/miniconda3/etc/fish/conf.d/conda.fish
set -x TERMINFO /usr/share/terminfo/
set -x TERM xterm-256color
set -x TASKRC ~/.config/taskrc
set -gx PATH /usr/local/texlive/2025/bin/x86_64-linux $PATH
set -gx MANPATH /usr/local/texlive/2025/texmf-dist/doc/man $MANPATH
set -gx INFOPATH /usr/local/texlive/2025/texmf-dist/doc/info $INFOPATH

zoxide init fish | source
starship init fish | source

abbr -a tadideas "task add project:ideas +parked"
abbr -a tadrice "task add project:rice +parked"
abbr -a tadimp "task add project:imp +parked"
abbr -a tadlife "task add project:life"
abbr -a tadschoolwork "task add project:schoolwork"
abbr -a tall "task status:pending"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/wurtle/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/home/wurtle/Downloads/google-cloud-sdk/path.fish.inc'; end

# Created by `pipx` on 2026-02-01 19:17:51

set PATH $PATH /home/wurtle/.local/bin
