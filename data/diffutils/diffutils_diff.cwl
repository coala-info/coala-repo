cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diff
label: diffutils_diff
doc: "Compare FILES line by line. FILES are 'FILE1 FILE2' or 'DIR1 DIR2' or 'DIR FILE'
  or 'FILE DIR'. Exit status is 0 if inputs are the same, 1 if different, 2 if trouble.\n\nTool
  homepage: https://www.gnu.org/software/diffutils/"
inputs:
  - id: file1
    type:
      - File
      - Directory
    doc: First file (or directory) to compare.
    inputBinding:
      position: 10
  - id: file2
    type:
      - File
      - Directory
    doc: Second file (or directory) to compare.
    inputBinding:
      position: 11
  - id: normal
    type:
      - 'null'
      - boolean
    doc: Output a normal diff (the default).
    inputBinding:
      position: 1
      prefix: --normal
  - id: brief
    type:
      - 'null'
      - boolean
    doc: Report only when files differ.
    inputBinding:
      position: 1
      prefix: --brief
  - id: report_identical_files
    type:
      - 'null'
      - boolean
    doc: Report when two files are the same.
    inputBinding:
      position: 1
      prefix: --report-identical-files
  - id: context
    type:
      - 'null'
      - int
    doc: Output NUM (default 3) lines of copied context.
    inputBinding:
      position: 1
      prefix: '--context='
      separate: false
  - id: unified
    type:
      - 'null'
      - int
    doc: Output NUM (default 3) lines of unified context.
    inputBinding:
      position: 1
      prefix: '--unified='
      separate: false
  - id: ed
    type:
      - 'null'
      - boolean
    doc: Output an ed script.
    inputBinding:
      position: 1
      prefix: --ed
  - id: rcs
    type:
      - 'null'
      - boolean
    doc: Output an RCS format diff.
    inputBinding:
      position: 1
      prefix: --rcs
  - id: side_by_side
    type:
      - 'null'
      - boolean
    doc: Output in two columns.
    inputBinding:
      position: 1
      prefix: --side-by-side
  - id: width
    type:
      - 'null'
      - int
    doc: Output at most NUM (default 130) print columns.
    inputBinding:
      position: 1
      prefix: '--width='
      separate: false
  - id: left_column
    type:
      - 'null'
      - boolean
    doc: Output only the left column of common lines.
    inputBinding:
      position: 1
      prefix: --left-column
  - id: suppress_common_lines
    type:
      - 'null'
      - boolean
    doc: Do not output common lines.
    inputBinding:
      position: 1
      prefix: --suppress-common-lines
  - id: show_c_function
    type:
      - 'null'
      - boolean
    doc: Show which C function each change is in.
    inputBinding:
      position: 1
      prefix: --show-c-function
  - id: show_function_line
    type:
      - 'null'
      - string
    doc: Show the most recent line matching RE.
    inputBinding:
      position: 1
      prefix: '--show-function-line='
      separate: false
  - id: label
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --label
    doc: Use LABEL instead of file name and timestamp (can be repeated).
    inputBinding:
      position: 1
  - id: expand_tabs
    type:
      - 'null'
      - boolean
    doc: Expand tabs to spaces in output.
    inputBinding:
      position: 1
      prefix: --expand-tabs
  - id: initial_tab
    type:
      - 'null'
      - boolean
    doc: Make tabs line up by prepending a tab.
    inputBinding:
      position: 1
      prefix: --initial-tab
  - id: tabsize
    type:
      - 'null'
      - int
    doc: Tab stops every NUM (default 8) print columns.
    inputBinding:
      position: 1
      prefix: '--tabsize='
      separate: false
  - id: suppress_blank_empty
    type:
      - 'null'
      - boolean
    doc: Suppress space or tab before empty output lines.
    inputBinding:
      position: 1
      prefix: --suppress-blank-empty
  - id: paginate
    type:
      - 'null'
      - boolean
    doc: Pass output through 'pr' to paginate it.
    inputBinding:
      position: 1
      prefix: --paginate
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recursively compare any subdirectories found.
    inputBinding:
      position: 1
      prefix: --recursive
  - id: no_dereference
    type:
      - 'null'
      - boolean
    doc: Don't follow symbolic links.
    inputBinding:
      position: 1
      prefix: --no-dereference
  - id: new_file
    type:
      - 'null'
      - boolean
    doc: Treat absent files as empty.
    inputBinding:
      position: 1
      prefix: --new-file
  - id: unidirectional_new_file
    type:
      - 'null'
      - boolean
    doc: Treat absent first files as empty.
    inputBinding:
      position: 1
      prefix: --unidirectional-new-file
  - id: ignore_file_name_case
    type:
      - 'null'
      - boolean
    doc: Ignore case when comparing file names.
    inputBinding:
      position: 1
      prefix: --ignore-file-name-case
  - id: no_ignore_file_name_case
    type:
      - 'null'
      - boolean
    doc: Consider case when comparing file names.
    inputBinding:
      position: 1
      prefix: --no-ignore-file-name-case
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude files that match PAT.
    inputBinding:
      position: 1
      prefix: '--exclude='
      separate: false
  - id: exclude_from
    type:
      - 'null'
      - File
    doc: Exclude files that match any pattern in FILE.
    inputBinding:
      position: 1
      prefix: '--exclude-from='
      separate: false
  - id: starting_file
    type:
      - 'null'
      - string
    doc: Start with FILE when comparing directories.
    inputBinding:
      position: 1
      prefix: '--starting-file='
      separate: false
  - id: from_file

    type:
      - 'null'
      - File
      - Directory
    doc: Compare FILE1 to all operands; FILE1 can be a directory.
    inputBinding:
      position: 1
      prefix: '--from-file='
      separate: false
  - id: to_file

    type:
      - 'null'
      - File
      - Directory
    doc: Compare all operands to FILE2; FILE2 can be a directory.
    inputBinding:
      position: 1
      prefix: '--to-file='
      separate: false
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case differences in file contents.
    inputBinding:
      position: 1
      prefix: --ignore-case
  - id: ignore_tab_expansion
    type:
      - 'null'
      - boolean
    doc: Ignore changes due to tab expansion.
    inputBinding:
      position: 1
      prefix: --ignore-tab-expansion
  - id: ignore_trailing_space
    type:
      - 'null'
      - boolean
    doc: Ignore white space at line end.
    inputBinding:
      position: 1
      prefix: --ignore-trailing-space
  - id: ignore_space_change
    type:
      - 'null'
      - boolean
    doc: Ignore changes in the amount of white space.
    inputBinding:
      position: 1
      prefix: --ignore-space-change
  - id: ignore_all_space
    type:
      - 'null'
      - boolean
    doc: Ignore all white space.
    inputBinding:
      position: 1
      prefix: --ignore-all-space
  - id: ignore_blank_lines
    type:
      - 'null'
      - boolean
    doc: Ignore changes where lines are all blank.
    inputBinding:
      position: 1
      prefix: --ignore-blank-lines
  - id: ignore_matching_lines
    type:
      - 'null'
      - string
    doc: Ignore changes where all lines match RE.
    inputBinding:
      position: 1
      prefix: '--ignore-matching-lines='
      separate: false
  - id: text
    type:
      - 'null'
      - boolean
    doc: Treat all files as text.
    inputBinding:
      position: 1
      prefix: --text
  - id: strip_trailing_cr
    type:
      - 'null'
      - boolean
    doc: Strip trailing carriage return on input.
    inputBinding:
      position: 1
      prefix: --strip-trailing-cr
  - id: ifdef
    type:
      - 'null'
      - string
    doc: Output merged file with '#ifdef NAME' diffs.
    inputBinding:
      position: 1
      prefix: '--ifdef='
      separate: false
  - id: old_group_format
    type:
      - 'null'
      - string
    doc: Format old input groups with GFMT.
    inputBinding:
      position: 1
      prefix: '--old-group-format='
      separate: false
  - id: new_group_format
    type:
      - 'null'
      - string
    doc: Format new input groups with GFMT.
    inputBinding:
      position: 1
      prefix: '--new-group-format='
      separate: false
  - id: unchanged_group_format
    type:
      - 'null'
      - string
    doc: Format unchanged input groups with GFMT.
    inputBinding:
      position: 1
      prefix: '--unchanged-group-format='
      separate: false
  - id: changed_group_format
    type:
      - 'null'
      - string
    doc: Format changed input groups with GFMT.
    inputBinding:
      position: 1
      prefix: '--changed-group-format='
      separate: false
  - id: line_format
    type:
      - 'null'
      - string
    doc: Format all input lines with LFMT.
    inputBinding:
      position: 1
      prefix: '--line-format='
      separate: false
  - id: old_line_format
    type:
      - 'null'
      - string
    doc: Format old input lines with LFMT.
    inputBinding:
      position: 1
      prefix: '--old-line-format='
      separate: false
  - id: new_line_format
    type:
      - 'null'
      - string
    doc: Format new input lines with LFMT.
    inputBinding:
      position: 1
      prefix: '--new-line-format='
      separate: false
  - id: unchanged_line_format
    type:
      - 'null'
      - string
    doc: Format unchanged input lines with LFMT.
    inputBinding:
      position: 1
      prefix: '--unchanged-line-format='
      separate: false
  - id: minimal
    type:
      - 'null'
      - boolean
    doc: Try hard to find a smaller set of changes.
    inputBinding:
      position: 1
      prefix: --minimal
  - id: horizon_lines
    type:
      - 'null'
      - int
    doc: Keep NUM lines of the common prefix and suffix.
    inputBinding:
      position: 1
      prefix: '--horizon-lines='
      separate: false
  - id: speed_large_files
    type:
      - 'null'
      - boolean
    doc: Assume large files and many scattered small changes.
    inputBinding:
      position: 1
      prefix: --speed-large-files
  - id: color
    type:
      - 'null'
      - type: enum
        symbols:
          - never
          - always
          - auto
    doc: Color output; WHEN is 'never', 'always', or 'auto'.
    inputBinding:
      position: 1
      prefix: --color=
      separate: false
  - id: palette
    type:
      - 'null'
      - string
    doc: The colors to use when --color is active; a colon-separated list of terminfo capabilities.
    inputBinding:
      position: 1
      prefix: '--palette='
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: The differences between the inputs (empty when they are the same).
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diffutils:3.10
stdout: diffutils_diff.out
successCodes:
  - 0
  - 1
