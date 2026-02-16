function nvim
    set -l socket_path "/tmp/kitty_nvim_fix-$KITTY_PID"

    if not set -q KITTY_PID; and set -q TMUX
      set KITTY_PID (tmux show-env KITTY_PID | cut -d = -f2)
      set socket_path "/tmp/kitty_nvim_fix-$KITTY_PID"
    end

    if test -S "$socket_path"

        # kitten @ --to=unix:$socket_path set-spacing padding-left=0 padding-right=0 padding-top=0 padding-bottom=0
        kitten @ --to=unix:$socket_path set-colors --all --config ~/.config/kitty/tokyonight_storm.conf
        kitten @ --to=unix:$socket_path set-background-opacity 1.0

        command nvim $argv

        # kitten @ --to=unix:$socket_path set-spacing padding-left=5 padding-right=5 padding-top=5 padding-bottom=5
        kitten @ --to=unix:$socket_path set-colors --all --config ~/.cache/wal/colors-kitty.conf
        kitten @ --to=unix:$socket_path set-background-opacity 0.75
    else
        command nvim $argv
        # echo "hi!" # debugging
    end
end
