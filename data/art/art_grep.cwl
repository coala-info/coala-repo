cwlVersion: v1.2
class: CommandLineTool
baseCommand: grep
label: art_grep
doc: "Search for PATTERN in FILEs (or stdin)\n\nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: pattern
    type:
      - 'null'
      - string
    doc: Pattern to search for (required if -e or -f are not used)
    inputBinding:
      position: 1
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to search in
    inputBinding:
      position: 2
  - id: after_context
    type:
      - 'null'
      - int
    doc: Print N lines of trailing context
    inputBinding:
      position: 103
      prefix: -A
  - id: before_context
    type:
      - 'null'
      - int
    doc: Print N lines of leading context
    inputBinding:
      position: 103
      prefix: -B
  - id: context
    type:
      - 'null'
      - int
    doc: Same as '-A N -B N'
    inputBinding:
      position: 103
      prefix: -C
  - id: count
    type:
      - 'null'
      - boolean
    doc: Show only count of matching lines
    inputBinding:
      position: 103
      prefix: -c
  - id: dereference_recursive
    type:
      - 'null'
      - boolean
    doc: Recurse and dereference symlinks
    inputBinding:
      position: 103
      prefix: -R
  - id: extended_regexp
    type:
      - 'null'
      - boolean
    doc: PATTERN is an extended regexp
    inputBinding:
      position: 103
      prefix: -E
  - id: file
    type:
      - 'null'
      - type: array
        items: File
    doc: Read pattern from file
    inputBinding:
      position: 103
      prefix: -f
  - id: files_with_matches
    type:
      - 'null'
      - boolean
    doc: Show only names of files that match
    inputBinding:
      position: 103
      prefix: -l
  - id: files_without_match
    type:
      - 'null'
      - boolean
    doc: Show only names of files that don't match
    inputBinding:
      position: 103
      prefix: -L
  - id: fixed_strings
    type:
      - 'null'
      - boolean
    doc: PATTERN is a literal (not regexp)
    inputBinding:
      position: 103
      prefix: -F
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
  - id: line_number
    type:
      - 'null'
      - boolean
    doc: Add 'line_no:' prefix
    inputBinding:
      position: 103
      prefix: -n
  - id: line_regexp
    type:
      - 'null'
      - boolean
    doc: Match whole lines only
    inputBinding:
      position: 103
      prefix: -x
  - id: max_count
    type:
      - 'null'
      - int
    doc: Match up to N times per file
    inputBinding:
      position: 103
      prefix: -m
  - id: no_filename
    type:
      - 'null'
      - boolean
    doc: Do not add 'filename:' prefix
    inputBinding:
      position: 103
      prefix: -h
  - id: no_messages
    type:
      - 'null'
      - boolean
    doc: Suppress open and read errors
    inputBinding:
      position: 103
      prefix: -s
  - id: only_matching
    type:
      - 'null'
      - boolean
    doc: Show only the matching part of line
    inputBinding:
      position: 103
      prefix: -o
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
  - id: regexp
    type:
      - 'null'
      - type: array
        items: string
    doc: Pattern to match
    inputBinding:
      position: 103
      prefix: -e
  - id: with_filename
    type:
      - 'null'
      - boolean
    doc: Add 'filename:' prefix
    inputBinding:
      position: 103
      prefix: -H
  - id: word_regexp
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
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_grep.out
