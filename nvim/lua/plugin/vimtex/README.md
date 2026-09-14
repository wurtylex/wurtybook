# LaTeX PDF search

Open a `.tex` file in Neovim. The local leader is Space:

- `Space l l`: start/stop continuous compilation with latexmk. Save to rebuild.
- `Space l v`: open the PDF at the source cursor (forward search).
- `Ctrl` + left-click in Zathura: jump to the source (inverse search).
- `:VimtexInfo`: inspect the compiler, PDF path, and viewer commands.

Compilation generates SyncTeX data with `-synctex=1`. Auxiliary files go in
`.build`; latexmk keeps the PDF and `.synctex.gz` together in the project root.
For existing documents, recompile once if the SyncTeX file is missing.

On Linux, the configuration uses `zathura_simple` on Wayland or when `xdotool`
is unavailable, and `zathura` otherwise. macOS uses Skim.

VimTeX supplies the inverse-search callback when it launches Zathura. The
`synctex-editor-command` in `~/.config/zathura/zathurarc` also supports PDFs
opened separately. Keep the corresponding LaTeX project open in Neovim;
the callback routes to that session. VimTeX must remain eagerly loaded so
the headless callback can find `:VimtexInverseSearch`.

Restart Neovim and reopen Zathura after changing the configuration. On Wayland,
inverse search moves the editor cursor, but focusing the terminal window is
controlled by the compositor and may require switching back manually.

Reference: [VimTeX documentation](https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt)
(`vimtex-view-zathura` and `vimtex-synctex`).
