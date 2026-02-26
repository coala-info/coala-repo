cwlVersion: v1.2
class: CommandLineTool
baseCommand: grep
label: seqfu_grep
doc: "Print sequences selected if they match patterns or contain oligonucleotides
  using regular expressions.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files containing sequences
    inputBinding:
      position: 1
  - id: append_positions
    type:
      - 'null'
      - boolean
    doc: Append matching positions to the sequence comment
    inputBinding:
      position: 102
      prefix: --append-pos
  - id: full_match
    type:
      - 'null'
      - boolean
    doc: The string or pattern covers the whole name (mainly used without -c)
    inputBinding:
      position: 102
      prefix: --full
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case when matching names (is already enabled with regexes)
    inputBinding:
      position: 102
      prefix: --ignore-case
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: Invert match (print sequences that do not match)
    inputBinding:
      position: 102
      prefix: --invert-match
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Maximum mismatches allowed
    default: 0
    inputBinding:
      position: 102
      prefix: --max-mismatches
  - id: min_matches
    type:
      - 'null'
      - string
    doc: Minimum number of matches
    inputBinding:
      position: 102
      prefix: --min-matches
  - id: name_string
    type:
      - 'null'
      - string
    doc: String required inside the sequence name (see -f)
    inputBinding:
      position: 102
      prefix: --name
  - id: oligo_sequence
    type:
      - 'null'
      - string
    doc: Oligonucleotide required in the sequence, using ambiguous bases and 
      reverse complement
    inputBinding:
      position: 102
      prefix: --oligo
  - id: regex_pattern
    type:
      - 'null'
      - string
    doc: Pattern to be matched in sequence name
    inputBinding:
      position: 102
      prefix: --regex
  - id: search_comment
    type:
      - 'null'
      - boolean
    doc: Also search -n and -r in the comment
    inputBinding:
      position: 102
      prefix: --comment
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: word_match
    type:
      - 'null'
      - boolean
    doc: The string or pattern is a whole word
    inputBinding:
      position: 102
      prefix: --word
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_grep.out
