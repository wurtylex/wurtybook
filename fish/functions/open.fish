# Defined in embedded:functions/open.fish @ line 7
function open --description 'Open file in default application'
        set -l options h/help
        argparse -n open $options -- $argv
        or return

        if set -q _flag_help
            __fish_print_help open
            return 0
        end

        if not set -q argv[1]
            printf (_ "%s: Expected at least %d args, got only %d\n") open 1 0 >&2
            return 1
        end

        if type -q -f cygstart
            for i in $argv
                cygstart $i
            end
        else if type -q -f xdg-open
            for i in $argv
                switch (string lower -- $i)
                    case '*.pdf' '*.epub'
                        # skip xdg-open's slow generic path on niri; zathura is
                        # the xdg default for these anyway
                        setsid -f zathura -- $i >/dev/null 2>&1
                    case '*'
                        setsid -f xdg-open $i >/dev/null 2>&1
                end
            end
        else
            echo (_ 'No open utility found. Try installing "xdg-open" or "xdg-utils".') >&2
        end

end
