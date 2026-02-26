cwlVersion: v1.2
class: CommandLineTool
baseCommand: grep
label: blinker_grep
doc: "Search for PATTERN in FILEs (or stdin)\n\nTool homepage: https://github.com/blinksh/blink"
inputs:
  - id: pattern
    type: string
    doc: Pattern to search for
    inputBinding:
      position: 1
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to search in (or stdin)
    inputBinding:
      position: 2
  - id: add_filename_prefix
    type:
      - 'null'
      - boolean
    doc: Add 'filename:' prefix
    inputBinding:
      position: 103
      prefix: -H
  - id: add_line_no_prefix
    type:
      - 'null'
      - boolean
    doc: Add 'line_no:' prefix
    inputBinding:
      position: 103
      prefix: -n
  - id: context
    type:
      - 'null'
      - int
    doc: Same as '-A N -B N'
    inputBinding:
      position: 103
      prefix: -C
  - id: extended_regexp
    type:
      - 'null'
      - boolean
    doc: PATTERN is an extended regexp
    inputBinding:
      position: 103
      prefix: -E
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case
    inputBinding:
      position: 103
      prefix: -i
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: Select non-matching lines
    inputBinding:
      position: 103
      prefix: -v
  - id: leading_context
    type:
      - 'null'
      - int
    doc: Print N lines of leading context
    inputBinding:
      position: 103
      prefix: -B
  - id: literal_pattern
    type:
      - 'null'
      - boolean
    doc: PATTERN is a literal (not regexp)
    inputBinding:
      position: 103
      prefix: -F
  - id: max_matches_per_file
    type:
      - 'null'
      - int
    doc: Match up to N times per file
    inputBinding:
      position: 103
      prefix: -m
  - id: no_filename_prefix
    type:
      - 'null'
      - boolean
    doc: Do not add 'filename:' prefix
    inputBinding:
      position: 103
      prefix: -h
  - id: pattern_explicit
    type:
      - 'null'
      - type: array
        items: string
    doc: Pattern to match
    inputBinding:
      position: 103
      prefix: -e
  - id: pattern_file
    type:
      - 'null'
      - File
    doc: Read pattern from file
    inputBinding:
      position: 103
      prefix: -f
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet. Return 0 if PATTERN is found, 1 otherwise
    inputBinding:
      position: 103
      prefix: -q
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recurse
    inputBinding:
      position: 103
      prefix: -r
  - id: show_only_count
    type:
      - 'null'
      - boolean
    doc: Show only count of matching lines
    inputBinding:
      position: 103
      prefix: -c
  - id: show_only_matching_filenames
    type:
      - 'null'
      - boolean
    doc: Show only names of files that match
    inputBinding:
      position: 103
      prefix: -l
  - id: show_only_matching_part
    type:
      - 'null'
      - boolean
    doc: Show only the matching part of line
    inputBinding:
      position: 103
      prefix: -o
  - id: show_only_non_matching_filenames
    type:
      - 'null'
      - boolean
    doc: Show only names of files that don't match
    inputBinding:
      position: 103
      prefix: -L
  - id: suppress_errors
    type:
      - 'null'
      - boolean
    doc: Suppress open and read errors
    inputBinding:
      position: 103
      prefix: -s
  - id: trailing_context
    type:
      - 'null'
      - int
    doc: Print N lines of trailing context
    inputBinding:
      position: 103
      prefix: -A
  - id: whole_lines
    type:
      - 'null'
      - boolean
    doc: Match whole lines only
    inputBinding:
      position: 103
      prefix: -x
  - id: whole_words
    type:
      - 'null'
      - boolean
    doc: Match whole words only
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blinker:1.4--py35_0
stdout: blinker_grep.out
