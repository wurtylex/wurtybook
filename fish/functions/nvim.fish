function nvim
	# kitten @ set-spacing padding-left=0 padding-right=0 padding-top=0 padding-bottom=0
  kitten @ set-colors --all --config ~/.config/kitty/tokyonight_storm.conf
  kitten @ set-background-opacity 1.0
	command nvim $argv
  kitten @ set-colors --all --config ~/.cache/wal/colors-kitty.conf
  kitten @ set-background-opacity 0.75
	# kitten @ set-spacing padding-left=5 padding-right=5 padding-top=5 padding-bottom=5
end
