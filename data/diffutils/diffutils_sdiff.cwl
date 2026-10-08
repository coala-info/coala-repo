cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sdiff
label: diffutils_sdiff
doc: "Side-by-side merge of differences between FILE1 and FILE2. Exit status is 0 if
  inputs are the same, 1 if different, 2 if trouble. The interactive merge mode (-o/--output)
  needs a terminal and is not wrapped.\n\nTool homepage: https://www.gnu.org/software/diffutils/"
inputs:
  - id: file1
    type: File
    doc: First file to compare.
    inputBinding:
      position: 10
  - id: file2
    type: File
    doc: Second file to compare.
    inputBinding:
      position: 11
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Consider upper- and lower-case to be the same.
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
    doc: Ignore changes whose lines are all blank.
    inputBinding:
      position: 1
      prefix: --ignore-blank-lines
  - id: ignore_matching_lines
    type:
      - 'null'
      - string
    doc: Ignore changes all whose lines match RE.
    inputBinding:
      position: 1
      prefix: '--ignore-matching-lines='
      separate: false
  - id: strip_trailing_cr
    type:
      - 'null'
      - boolean
    doc: Strip trailing carriage return on input.
    inputBinding:
      position: 1
      prefix: --strip-trailing-cr
  - id: text
    type:
      - 'null'
      - boolean
    doc: Treat all files as text.
    inputBinding:
      position: 1
      prefix: --text
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
  - id: expand_tabs
    type:
      - 'null'
      - boolean
    doc: Expand tabs to spaces in output.
    inputBinding:
      position: 1
      prefix: --expand-tabs
  - id: tabsize
    type:
      - 'null'
      - int
    doc: Tab stops at every NUM (default 8) print columns.
    inputBinding:
      position: 1
      prefix: '--tabsize='
      separate: false
  - id: minimal
    type:
      - 'null'
      - boolean
    doc: Try hard to find a smaller set of changes.
    inputBinding:
      position: 1
      prefix: --minimal
  - id: speed_large_files
    type:
      - 'null'
      - boolean
    doc: Assume large files, many scattered small changes.
    inputBinding:
      position: 1
      prefix: --speed-large-files
  - id: diff_program
    type:
      - 'null'
      - string
    doc: Use PROGRAM to compare files.
    inputBinding:
      position: 1
      prefix: '--diff-program='
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Side-by-side listing of the two files with change markers.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diffutils:3.10
stdout: diffutils_sdiff.out
successCodes:
  - 0
  - 1
