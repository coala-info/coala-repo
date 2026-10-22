cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - grep
label: seqfu_grep
doc: "Print sequences selected if they match patterns or contain oligonucleotides\nusing regular expressions.\n\
  \nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA/FASTQ files
    inputBinding:
      position: 1
  - id: name
    type:
      - 'null'
      - string
    doc: String required inside the sequence name (see -f)
    inputBinding:
      position: 102
      prefix: --name
  - id: regex
    type:
      - 'null'
      - string
    doc: Pattern to be matched in sequence name
    inputBinding:
      position: 102
      prefix: --regex
  - id: comment
    type:
      - 'null'
      - boolean
    doc: Also search -n and -r in the comment
    inputBinding:
      position: 102
      prefix: --comment
  - id: full
    type:
      - 'null'
      - boolean
    doc: The string or pattern covers the whole name (mainly used without -c)
    inputBinding:
      position: 102
      prefix: --full
  - id: word
    type:
      - 'null'
      - boolean
    doc: The string or pattern is a whole word
    inputBinding:
      position: 102
      prefix: --word
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case when matching names (is already enabled with regexes)
    inputBinding:
      position: 102
      prefix: --ignore-case
  - id: oligo
    type:
      - 'null'
      - string
    doc: Oligonucleotide required in the sequence, using ambiguous bases and reverse complement
    inputBinding:
      position: 102
      prefix: --oligo
  - id: append_pos
    type:
      - 'null'
      - boolean
    doc: Append matching positions to the sequence comment
    inputBinding:
      position: 102
      prefix: --append-pos
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: 'Maximum mismatches allowed [default: 0]'
    inputBinding:
      position: 102
      prefix: --max-mismatches
  - id: min_matches
    type:
      - 'null'
      - int
    doc: 'Minimum number of matches [default: oligo-length]'
    inputBinding:
      position: 102
      prefix: --min-matches
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: Invert match (print sequences that do not match)
    inputBinding:
      position: 102
      prefix: --invert-match
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_grep.out
