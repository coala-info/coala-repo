cwlVersion: v1.2
class: CommandLineTool
baseCommand: vim
label: biosyntax-vim_view
doc: "Vi IMproved, a text editor\n\nTool homepage: https://github.com/bioSyntax/bioSyntax-vim"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: edit specified file(s)
    inputBinding:
      position: 1
  - id: arabic_mode
    type:
      - 'null'
      - boolean
    doc: Start in Arabic mode
    inputBinding:
      position: 102
      prefix: -A
  - id: binary_mode
    type:
      - 'null'
      - boolean
    doc: Binary mode
    inputBinding:
      position: 102
      prefix: -b
  - id: clean
    type:
      - 'null'
      - boolean
    doc: "'nocompatible', Vim defaults, no plugins, no viminfo"
    inputBinding:
      position: 102
      prefix: --clean
  - id: compatible
    type:
      - 'null'
      - boolean
    doc: "Compatible with Vi: 'compatible'"
    inputBinding:
      position: 102
      prefix: -C
  - id: debugging_mode
    type:
      - 'null'
      - boolean
    doc: Debugging mode
    inputBinding:
      position: 102
      prefix: -D
  - id: diff_mode
    type:
      - 'null'
      - boolean
    doc: Diff mode (like "vimdiff")
    inputBinding:
      position: 102
      prefix: -d
  - id: easy_mode
    type:
      - 'null'
      - boolean
    doc: Easy mode (like "evim", modeless)
    inputBinding:
      position: 102
      prefix: -y
  - id: edit_encrypted
    type:
      - 'null'
      - boolean
    doc: Edit encrypted files
    inputBinding:
      position: 102
      prefix: -x
  - id: ex_mode
    type:
      - 'null'
      - boolean
    doc: Ex mode (like "ex")
    inputBinding:
      position: 102
      prefix: -e
  - id: farsi_mode
    type:
      - 'null'
      - boolean
    doc: Start in Farsi mode
    inputBinding:
      position: 102
      prefix: -F
  - id: hebrew_mode
    type:
      - 'null'
      - boolean
    doc: Start in Hebrew mode
    inputBinding:
      position: 102
      prefix: -H
  - id: improved_ex_mode
    type:
      - 'null'
      - boolean
    doc: Improved Ex mode
    inputBinding:
      position: 102
      prefix: -E
  - id: lisp_mode
    type:
      - 'null'
      - boolean
    doc: Lisp mode
    inputBinding:
      position: 102
      prefix: -l
  - id: list_swap_files
    type:
      - 'null'
      - boolean
    doc: List swap files and exit
    inputBinding:
      position: 102
      prefix: -r
  - id: no_modifications_text
    type:
      - 'null'
      - boolean
    doc: Modifications in text not allowed
    inputBinding:
      position: 102
      prefix: -M
  - id: no_modifications_writing
    type:
      - 'null'
      - boolean
    doc: Modifications (writing files) not allowed
    inputBinding:
      position: 102
      prefix: -m
  - id: no_plugin
    type:
      - 'null'
      - boolean
    doc: Don't load plugin scripts
    inputBinding:
      position: 102
      prefix: --noplugin
  - id: no_swap_file
    type:
      - 'null'
      - boolean
    doc: No swap file, use memory only
    inputBinding:
      position: 102
      prefix: -n
  - id: nocompatible
    type:
      - 'null'
      - boolean
    doc: "Not fully Vi compatible: 'nocompatible'"
    inputBinding:
      position: 102
      prefix: -N
  - id: not_a_term
    type:
      - 'null'
      - boolean
    doc: Skip warning for input/output not being a terminal
    inputBinding:
      position: 102
      prefix: --not-a-term
  - id: open_windows
    type:
      - 'null'
      - int
    doc: 'Open N windows (default: one for each file)'
    inputBinding:
      position: 102
      prefix: -o
  - id: open_windows_vertical
    type:
      - 'null'
      - int
    doc: Like -o but split vertically
    inputBinding:
      position: 102
      prefix: -O
  - id: post_command
    type:
      - 'null'
      - string
    doc: Execute <command> after loading the first file
    inputBinding:
      position: 102
      prefix: -c
  - id: pre_command
    type:
      - 'null'
      - string
    doc: Execute <command> before loading any vimrc file
    inputBinding:
      position: 102
      prefix: --cmd
  - id: readonly_mode
    type:
      - 'null'
      - boolean
    doc: Readonly mode (like "view")
    inputBinding:
      position: 102
      prefix: -R
  - id: restricted_mode
    type:
      - 'null'
      - boolean
    doc: Restricted mode (like "rvim")
    inputBinding:
      position: 102
      prefix: -Z
  - id: script_in
    type:
      - 'null'
      - File
    doc: Read Normal mode commands from file <scriptin>
    inputBinding:
      position: 102
      prefix: -s
  - id: silent_mode
    type:
      - 'null'
      - boolean
    doc: Silent (batch) mode (only for "ex")
    inputBinding:
      position: 102
      prefix: -s
  - id: source_session
    type:
      - 'null'
      - File
    doc: Source file <session> after loading the first file
    inputBinding:
      position: 102
      prefix: -S
  - id: start_at_line
    type:
      - 'null'
      - int
    doc: Start at line <lnum> or end of file
    inputBinding:
      position: 102
      prefix: +
  - id: tab_pages
    type:
      - 'null'
      - int
    doc: 'Open N tab pages (default: one for each file)'
    inputBinding:
      position: 102
      prefix: -p
  - id: terminal_type
    type:
      - 'null'
      - string
    doc: Set terminal type to <terminal>
    inputBinding:
      position: 102
      prefix: -T
  - id: ttyfail
    type:
      - 'null'
      - boolean
    doc: Exit if input or output is not a terminal
    inputBinding:
      position: 102
      prefix: --ttyfail
  - id: vi_mode
    type:
      - 'null'
      - boolean
    doc: Vi mode (like "vi")
    inputBinding:
      position: 102
      prefix: -v
  - id: viminfo_file
    type:
      - 'null'
      - File
    doc: Use <viminfo> instead of .viminfo
    inputBinding:
      position: 102
      prefix: -i
  - id: vimrc_file
    type:
      - 'null'
      - File
    doc: Use <vimrc> instead of any .vimrc
    inputBinding:
      position: 102
      prefix: -u
outputs:
  - id: script_out_append
    type:
      - 'null'
      - File
    doc: Append all typed commands to file <scriptout>
    outputBinding:
      glob: $(inputs.script_out_append)
  - id: script_out_write
    type:
      - 'null'
      - File
    doc: Write all typed commands to file <scriptout>
    outputBinding:
      glob: $(inputs.script_out_write)
  - id: startup_time_file
    type:
      - 'null'
      - File
    doc: Write startup timing messages to <file>
    outputBinding:
      glob: $(inputs.startup_time_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosyntax-vim:v1.0.0b-1-deb_cv1
