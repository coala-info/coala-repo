cwlVersion: v1.2
class: CommandLineTool
baseCommand: diff
label: qcli_apply_diff
doc: "Compare FILES line by line.\n\nTool homepage: https://github.com/xyOz-dev/LogiQCLI"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Files to compare
    inputBinding:
      position: 1
  - id: brief
    type:
      - 'null'
      - boolean
    doc: report only when files differ
    inputBinding:
      position: 102
      prefix: --brief
  - id: color
    type:
      - 'null'
      - string
    doc: colorize the output; WHEN can be 'never', 'always', or 'auto' (the 
      default)
    inputBinding:
      position: 102
      prefix: --color
  - id: context
    type:
      - 'null'
      - int
    doc: output NUM (default 3) lines of copied context
    inputBinding:
      position: 102
      prefix: --context
  - id: ed
    type:
      - 'null'
      - boolean
    doc: output an ed script
    inputBinding:
      position: 102
      prefix: --ed
  - id: exclude
    type:
      - 'null'
      - string
    doc: exclude files that match PAT
    inputBinding:
      position: 102
      prefix: --exclude
  - id: exclude_from
    type:
      - 'null'
      - File
    doc: exclude files that match any pattern in FILE
    inputBinding:
      position: 102
      prefix: --exclude-from
  - id: expand_tabs
    type:
      - 'null'
      - boolean
    doc: expand tabs to spaces in output
    inputBinding:
      position: 102
      prefix: --expand-tabs
  - id: from_file
    type:
      - 'null'
      - File
    doc: compare FILE1 to all operands; FILE1 can be a directory
    inputBinding:
      position: 102
      prefix: --from-file
  - id: group_format
    type:
      - 'null'
      - string
    doc: format GTYPE input groups with GFMT
    inputBinding:
      position: 102
      prefix: --GTYPE-group-format
  - id: horizon_lines
    type:
      - 'null'
      - int
    doc: keep NUM lines of the common prefix and suffix
    inputBinding:
      position: 102
      prefix: --horizon-lines
  - id: ifdef
    type:
      - 'null'
      - string
    doc: output merged file with '#ifdef NAME' diffs
    inputBinding:
      position: 102
      prefix: --ifdef
  - id: ignore_all_space
    type:
      - 'null'
      - boolean
    doc: ignore all white space
    inputBinding:
      position: 102
      prefix: --ignore-all-space
  - id: ignore_blank_lines
    type:
      - 'null'
      - boolean
    doc: ignore changes where lines are all blank
    inputBinding:
      position: 102
      prefix: --ignore-blank-lines
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: ignore case differences in file contents
    inputBinding:
      position: 102
      prefix: --ignore-case
  - id: ignore_file_name_case
    type:
      - 'null'
      - boolean
    doc: ignore case when comparing file names
    inputBinding:
      position: 102
      prefix: --ignore-file-name-case
  - id: ignore_matching_lines
    type:
      - 'null'
      - string
    doc: ignore changes where all lines match RE
    inputBinding:
      position: 102
      prefix: --ignore-matching-lines
  - id: ignore_space_change
    type:
      - 'null'
      - boolean
    doc: ignore changes in the amount of white space
    inputBinding:
      position: 102
      prefix: --ignore-space-change
  - id: ignore_tab_expansion
    type:
      - 'null'
      - boolean
    doc: ignore changes due to tab expansion
    inputBinding:
      position: 102
      prefix: --ignore-tab-expansion
  - id: ignore_trailing_space
    type:
      - 'null'
      - boolean
    doc: ignore white space at line end
    inputBinding:
      position: 102
      prefix: --ignore-trailing-space
  - id: initial_tab
    type:
      - 'null'
      - boolean
    doc: make tabs line up by prepending a tab
    inputBinding:
      position: 102
      prefix: --initial-tab
  - id: label
    type:
      - 'null'
      - type: array
        items: string
    doc: use LABEL instead of file name and timestamp (can be repeated)
    inputBinding:
      position: 102
      prefix: --label
  - id: left_column
    type:
      - 'null'
      - boolean
    doc: output only the left column of common lines
    inputBinding:
      position: 102
      prefix: --left-column
  - id: line_format
    type:
      - 'null'
      - string
    doc: format all input lines with LFMT
    inputBinding:
      position: 102
      prefix: --line-format
  - id: ltype_line_format
    type:
      - 'null'
      - string
    doc: format LTYPE input lines with LFMT
    inputBinding:
      position: 102
      prefix: --LTYPE-line-format
  - id: minimal
    type:
      - 'null'
      - boolean
    doc: try hard to find a smaller set of changes
    inputBinding:
      position: 102
      prefix: --minimal
  - id: new_file
    type:
      - 'null'
      - boolean
    doc: treat absent files as empty
    inputBinding:
      position: 102
      prefix: --new-file
  - id: no_dereference
    type:
      - 'null'
      - boolean
    doc: don't follow symbolic links
    inputBinding:
      position: 102
      prefix: --no-dereference
  - id: no_ignore_file_name_case
    type:
      - 'null'
      - boolean
    doc: consider case when comparing file names
    inputBinding:
      position: 102
      prefix: --no-ignore-file-name-case
  - id: normal
    type:
      - 'null'
      - boolean
    doc: output a normal diff (the default)
    inputBinding:
      position: 102
      prefix: --normal
  - id: paginate
    type:
      - 'null'
      - boolean
    doc: pass output through 'pr' to paginate it
    inputBinding:
      position: 102
      prefix: --paginate
  - id: palette
    type:
      - 'null'
      - string
    doc: the colors to use when --color is active; PALETTE is a colon-separated 
      list of terminfo capabilities
    inputBinding:
      position: 102
      prefix: --palette
  - id: rcs
    type:
      - 'null'
      - boolean
    doc: output an RCS format diff
    inputBinding:
      position: 102
      prefix: --rcs
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: recursively compare any subdirectories found
    inputBinding:
      position: 102
      prefix: --recursive
  - id: report_identical_files
    type:
      - 'null'
      - boolean
    doc: report when two files are the same
    inputBinding:
      position: 102
      prefix: --report-identical-files
  - id: show_c_function
    type:
      - 'null'
      - boolean
    doc: show which C function each change is in
    inputBinding:
      position: 102
      prefix: --show-c-function
  - id: show_function_line
    type:
      - 'null'
      - string
    doc: show the most recent line matching RE
    inputBinding:
      position: 102
      prefix: --show-function-line
  - id: side_by_side
    type:
      - 'null'
      - boolean
    doc: output in two columns
    inputBinding:
      position: 102
      prefix: --side-by-side
  - id: speed_large_files
    type:
      - 'null'
      - boolean
    doc: assume large files and many scattered small changes
    inputBinding:
      position: 102
      prefix: --speed-large-files
  - id: starting_file
    type:
      - 'null'
      - File
    doc: start with FILE when comparing directories
    inputBinding:
      position: 102
      prefix: --starting-file
  - id: strip_trailing_cr
    type:
      - 'null'
      - boolean
    doc: strip trailing carriage return on input
    inputBinding:
      position: 102
      prefix: --strip-trailing-cr
  - id: suppress_blank_empty
    type:
      - 'null'
      - boolean
    doc: suppress space or tab before empty output lines
    inputBinding:
      position: 102
      prefix: --suppress-blank-empty
  - id: suppress_common_lines
    type:
      - 'null'
      - boolean
    doc: do not output common lines
    inputBinding:
      position: 102
      prefix: --suppress-common-lines
  - id: tabsize
    type:
      - 'null'
      - int
    doc: tab stops every NUM (default 8) print columns
    inputBinding:
      position: 102
      prefix: --tabsize
  - id: text
    type:
      - 'null'
      - boolean
    doc: treat all files as text
    inputBinding:
      position: 102
      prefix: --text
  - id: to_file
    type:
      - 'null'
      - File
    doc: compare all operands to FILE2; FILE2 can be a directory
    inputBinding:
      position: 102
      prefix: --to-file
  - id: unidirectional_new_file
    type:
      - 'null'
      - boolean
    doc: treat absent first files as empty
    inputBinding:
      position: 102
      prefix: --unidirectional-new-file
  - id: unified
    type:
      - 'null'
      - int
    doc: output NUM (default 3) lines of unified context
    inputBinding:
      position: 102
      prefix: --unified
  - id: width
    type:
      - 'null'
      - int
    doc: output at most NUM (default 130) print columns
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/qcli:v0.1.1-3-deb-py2_cv1
stdout: qcli_apply_diff.out
