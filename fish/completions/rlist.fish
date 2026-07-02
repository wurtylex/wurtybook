# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_rlist_global_optspecs
	string join \n db= no-color h/help V/version
end

function __fish_rlist_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_rlist_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_rlist_using_subcommand
	set -l cmd (__fish_rlist_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c rlist -n "__fish_rlist_needs_command" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_needs_command" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rlist -n "__fish_rlist_needs_command" -s V -l version -d 'Print version'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "add" -d 'Add a paper by arXiv id, DOI, URL, or title'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "list" -d 'List papers (default: your queue of to-read and reading)'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "show" -d 'Show full details of a paper (abstract, links, notes)'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "search" -d 'Full-text search across titles, authors, abstracts, tags, and notes'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "start" -d 'Mark paper(s) as currently reading'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "done" -d 'Mark paper(s) as read (optionally with a rating)'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "drop" -d 'Drop paper(s) you\'ve decided not to read'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "edit" -d 'Edit a paper\'s metadata, tags, priority, or status'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "note" -d 'Add, edit, or delete notes on a paper (no text opens $EDITOR)'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "open" -d 'Open a paper\'s page in the browser, or its PDF in your PDF viewer'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "rm" -d 'Remove paper(s) from the list'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "next" -d 'Suggest what to read next'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "tags" -d 'List all tags with paper counts'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "stats" -d 'Reading statistics'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "export" -d 'Export papers (bibtex, json, csv)'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "import" -d 'Import papers from a BibTeX or JSON file'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "path" -d 'Print the database file path'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "completions" -d 'Generate shell completions (fish, bash, zsh, ...)'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "uninstall" -d 'Uninstall rlist (keeps your reading list unless --purge)'
complete -c rlist -n "__fish_rlist_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c rlist -n "__fish_rlist_using_subcommand add" -l title -d 'Override / supply the title' -r
complete -c rlist -n "__fish_rlist_using_subcommand add" -l authors -d 'Authors, separated by \';\' (e.g. "Ada Lovelace; Alan Turing")' -r
complete -c rlist -n "__fish_rlist_using_subcommand add" -l year -d 'Publication year' -r
complete -c rlist -n "__fish_rlist_using_subcommand add" -l venue -d 'Venue (journal / conference)' -r
complete -c rlist -n "__fish_rlist_using_subcommand add" -l url -d 'Override / supply the paper URL' -r
complete -c rlist -n "__fish_rlist_using_subcommand add" -s t -l tag -d 'Tag(s), repeatable (comma-separated also works)' -r
complete -c rlist -n "__fish_rlist_using_subcommand add" -s p -l priority -d 'Priority: high, normal, low' -r
complete -c rlist -n "__fish_rlist_using_subcommand add" -l status -d 'Initial status (default: to-read), useful for backfilling read papers' -r
complete -c rlist -n "__fish_rlist_using_subcommand add" -s r -l rating -d 'Rating 1-5 (implies --status read)' -r
complete -c rlist -n "__fish_rlist_using_subcommand add" -l note -d 'Attach an initial note' -r
complete -c rlist -n "__fish_rlist_using_subcommand add" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand add" -l no-fetch -d 'Skip metadata fetching even for arXiv ids / DOIs'
complete -c rlist -n "__fish_rlist_using_subcommand add" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand add" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand list" -s s -l status -d 'Filter by status (to-read, reading, read, dropped), repeatable' -r
complete -c rlist -n "__fish_rlist_using_subcommand list" -s t -l tag -d 'Filter by tag (all must match), repeatable' -r
complete -c rlist -n "__fish_rlist_using_subcommand list" -s a -l author -d 'Filter by author substring' -r
complete -c rlist -n "__fish_rlist_using_subcommand list" -s y -l year -d 'Filter by publication year' -r
complete -c rlist -n "__fish_rlist_using_subcommand list" -l sort -d 'Sort by: priority, added, year, title, rating' -r
complete -c rlist -n "__fish_rlist_using_subcommand list" -s n -l limit -d 'Show at most N papers' -r
complete -c rlist -n "__fish_rlist_using_subcommand list" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand list" -s R -l reverse -d 'Reverse the sort order'
complete -c rlist -n "__fish_rlist_using_subcommand list" -s A -l all -d 'Include every status'
complete -c rlist -n "__fish_rlist_using_subcommand list" -l json -d 'Output as JSON'
complete -c rlist -n "__fish_rlist_using_subcommand list" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand list" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand show" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand show" -l json -d 'Output as JSON'
complete -c rlist -n "__fish_rlist_using_subcommand show" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand show" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand search" -s n -l limit -d 'Show at most N results' -r
complete -c rlist -n "__fish_rlist_using_subcommand search" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand search" -l json -d 'Output as JSON'
complete -c rlist -n "__fish_rlist_using_subcommand search" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand search" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand start" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand start" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand start" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand done" -s r -l rating -d 'Rating 1-5' -r
complete -c rlist -n "__fish_rlist_using_subcommand done" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand done" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand done" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand drop" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand drop" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand drop" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l title -d 'New title' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l authors -d 'Authors, separated by \';\'' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l year -d 'Publication year (0 clears it)' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l venue -d 'Venue (empty string clears it)' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l url -d 'Paper URL (empty string clears it)' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l pdf-url -d 'PDF URL (empty string clears it)' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l doi -d 'DOI (empty string clears it)' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l arxiv -d 'arXiv id (empty string clears it)' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -s t -l add-tag -d 'Add tag(s), repeatable' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l rm-tag -d 'Remove tag(s), repeatable' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -s p -l priority -d 'Priority: high, normal, low' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l status -d 'Status: to-read, reading, read, dropped' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -s r -l rating -d 'Rating 1-5 (0 clears it)' -r
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l pdf-file -d 'Copy a local PDF into the cache so `open --pdf` uses it' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand edit" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand edit" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand note; and not __fish_seen_subcommand_from rm edit help" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand note; and not __fish_seen_subcommand_from rm edit help" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand note; and not __fish_seen_subcommand_from rm edit help" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand note; and not __fish_seen_subcommand_from rm edit help" -a "rm" -d 'Delete a note (numbers shown in `rlist show`)'
complete -c rlist -n "__fish_rlist_using_subcommand note; and not __fish_seen_subcommand_from rm edit help" -a "edit" -d 'Rewrite a note (no text opens $EDITOR with the current note)'
complete -c rlist -n "__fish_rlist_using_subcommand note; and not __fish_seen_subcommand_from rm edit help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c rlist -n "__fish_rlist_using_subcommand note; and __fish_seen_subcommand_from rm" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand note; and __fish_seen_subcommand_from rm" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand note; and __fish_seen_subcommand_from rm" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand note; and __fish_seen_subcommand_from edit" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand note; and __fish_seen_subcommand_from edit" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand note; and __fish_seen_subcommand_from edit" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand note; and __fish_seen_subcommand_from help" -f -a "rm" -d 'Delete a note (numbers shown in `rlist show`)'
complete -c rlist -n "__fish_rlist_using_subcommand note; and __fish_seen_subcommand_from help" -f -a "edit" -d 'Rewrite a note (no text opens $EDITOR with the current note)'
complete -c rlist -n "__fish_rlist_using_subcommand note; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c rlist -n "__fish_rlist_using_subcommand open" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand open" -s p -l pdf -d 'Download the PDF (cached locally) and open it in your PDF viewer'
complete -c rlist -n "__fish_rlist_using_subcommand open" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand open" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand rm" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand rm" -s f -l force -d 'Don\'t ask for confirmation'
complete -c rlist -n "__fish_rlist_using_subcommand rm" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand rm" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand next" -s t -l tag -d 'Restrict to a tag, repeatable' -r
complete -c rlist -n "__fish_rlist_using_subcommand next" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand next" -l random -d 'Pick at random from the queue instead of by priority'
complete -c rlist -n "__fish_rlist_using_subcommand next" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand next" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand tags" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand tags" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand tags" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand stats" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand stats" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand stats" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand export" -s f -l format -d 'Output format: bibtex, json, csv' -r
complete -c rlist -n "__fish_rlist_using_subcommand export" -s o -l output -d 'Write to a file instead of stdout' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand export" -s s -l status -d 'Only papers with this status, repeatable' -r
complete -c rlist -n "__fish_rlist_using_subcommand export" -s t -l tag -d 'Only papers with this tag, repeatable' -r
complete -c rlist -n "__fish_rlist_using_subcommand export" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand export" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand export" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand import" -s f -l format -d 'Force format: bibtex or json (default: by file extension)' -r
complete -c rlist -n "__fish_rlist_using_subcommand import" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand import" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand import" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand path" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand path" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand path" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand completions" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand completions" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand completions" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand uninstall" -l db -d 'Path to the database (default: ~/.local/share/rlist/rlist.db, or $RLIST_DB)' -r -F
complete -c rlist -n "__fish_rlist_using_subcommand uninstall" -l purge -d 'Also delete the database (reading list, notes, everything)'
complete -c rlist -n "__fish_rlist_using_subcommand uninstall" -s f -l force -d 'Don\'t ask for confirmation'
complete -c rlist -n "__fish_rlist_using_subcommand uninstall" -l no-color -d 'Disable colored output (also respects NO_COLOR)'
complete -c rlist -n "__fish_rlist_using_subcommand uninstall" -s h -l help -d 'Print help'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "add" -d 'Add a paper by arXiv id, DOI, URL, or title'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "list" -d 'List papers (default: your queue of to-read and reading)'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "show" -d 'Show full details of a paper (abstract, links, notes)'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "search" -d 'Full-text search across titles, authors, abstracts, tags, and notes'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "start" -d 'Mark paper(s) as currently reading'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "done" -d 'Mark paper(s) as read (optionally with a rating)'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "drop" -d 'Drop paper(s) you\'ve decided not to read'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "edit" -d 'Edit a paper\'s metadata, tags, priority, or status'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "note" -d 'Add, edit, or delete notes on a paper (no text opens $EDITOR)'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "open" -d 'Open a paper\'s page in the browser, or its PDF in your PDF viewer'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "rm" -d 'Remove paper(s) from the list'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "next" -d 'Suggest what to read next'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "tags" -d 'List all tags with paper counts'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "stats" -d 'Reading statistics'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "export" -d 'Export papers (bibtex, json, csv)'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "import" -d 'Import papers from a BibTeX or JSON file'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "path" -d 'Print the database file path'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "completions" -d 'Generate shell completions (fish, bash, zsh, ...)'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "uninstall" -d 'Uninstall rlist (keeps your reading list unless --purge)'
complete -c rlist -n "__fish_rlist_using_subcommand help; and not __fish_seen_subcommand_from add list show search start done drop edit note open rm next tags stats export import path completions uninstall help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c rlist -n "__fish_rlist_using_subcommand help; and __fish_seen_subcommand_from note" -f -a "rm" -d 'Delete a note (numbers shown in `rlist show`)'
complete -c rlist -n "__fish_rlist_using_subcommand help; and __fish_seen_subcommand_from note" -f -a "edit" -d 'Rewrite a note (no text opens $EDITOR with the current note)'
