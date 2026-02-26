cwlVersion: v1.2
class: CommandLineTool
baseCommand: diff
label: genepop_test_diff
doc: "Compare files line by line and output the differences between them. This implementation
  supports unified diffs only.\n\nTool homepage: https://f-rousset.r-universe.dev/genepop"
inputs:
  - id: file1
    type: File
    doc: First file to compare
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: Second file to compare
    inputBinding:
      position: 2
  - id: align_tabs
    type:
      - 'null'
      - boolean
    doc: Make tabs line up by prefixing a tab when necessary
    inputBinding:
      position: 103
      prefix: -T
  - id: all_as_text
    type:
      - 'null'
      - boolean
    doc: Treat all files as text
    inputBinding:
      position: 103
      prefix: -a
  - id: context_lines
    type:
      - 'null'
      - int
    doc: Output LINES lines of context
    inputBinding:
      position: 103
      prefix: -U
  - id: expand_tabs
    type:
      - 'null'
      - boolean
    doc: Expand tabs to spaces in output
    inputBinding:
      position: 103
      prefix: -t
  - id: find_smaller_changes
    type:
      - 'null'
      - boolean
    doc: Try hard to find a smaller set of changes
    inputBinding:
      position: 103
      prefix: -d
  - id: ignore_all_whitespace
    type:
      - 'null'
      - boolean
    doc: Ignore all whitespace
    inputBinding:
      position: 103
      prefix: -w
  - id: ignore_blank_lines
    type:
      - 'null'
      - boolean
    doc: Ignore changes whose lines are all blank
    inputBinding:
      position: 103
      prefix: -B
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case differences
    inputBinding:
      position: 103
      prefix: -i
  - id: ignore_whitespace_amount
    type:
      - 'null'
      - boolean
    doc: Ignore changes in the amount of whitespace
    inputBinding:
      position: 103
      prefix: -b
  - id: label
    type:
      - 'null'
      - string
    doc: Use LABEL instead of the filename in the unified header
    inputBinding:
      position: 103
      prefix: -L
  - id: recurse
    type:
      - 'null'
      - boolean
    doc: Recurse
    inputBinding:
      position: 103
      prefix: -r
  - id: report_if_differ
    type:
      - 'null'
      - boolean
    doc: Output only whether files differ
    inputBinding:
      position: 103
      prefix: -q
  - id: report_if_same
    type:
      - 'null'
      - boolean
    doc: Report when two files are the same
    inputBinding:
      position: 103
      prefix: -s
  - id: start_file
    type:
      - 'null'
      - File
    doc: Start with FILE when comparing directories
    inputBinding:
      position: 103
      prefix: -S
  - id: treat_absent_as_empty
    type:
      - 'null'
      - boolean
    doc: Treat absent files as empty
    inputBinding:
      position: 103
      prefix: -N
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genepop:4.8.4--h9948957_0
stdout: genepop_test_diff.out
