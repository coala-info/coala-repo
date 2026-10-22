cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - grep
label: smof_grep
doc: "Extract entries whose header or sequence matches a pattern (based on GNU grep but operates on fasta entries).\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: pattern
    type: ['null', string]
    doc: "Pattern to match (not needed when patterns come from --file or --fastain)"
    inputBinding:
      position: 1
  - id: match_sequence
    type:
      - 'null'
      - boolean
    doc: "Match sequence rather than header"
    inputBinding:
      position: 100
      prefix: --match-sequence
  - id: file
    type:
      - 'null'
      - File
    doc: "Obtain patterns from FILE, one per line"
    inputBinding:
      position: 101
      prefix: --file
  - id: files_without_match
    type:
      - 'null'
      - boolean
    doc: "Print names of files with no matches"
    inputBinding:
      position: 102
      prefix: --files-without-match
  - id: files_with_matches
    type:
      - 'null'
      - boolean
    doc: "Print names of input files with matches"
    inputBinding:
      position: 103
      prefix: --files-with-matches
  - id: wrap
    type:
      - 'null'
      - string
    doc: "A regular expression to capture patterns"
    inputBinding:
      position: 104
      prefix: --wrap
  - id: perl_regexp
    type:
      - 'null'
      - boolean
    doc: "Treat patterns as perl regular expressions"
    inputBinding:
      position: 105
      prefix: --perl-regexp
  - id: ambiguous_nucl
    type:
      - 'null'
      - boolean
    doc: "Parse extended nucleotide alphabet"
    inputBinding:
      position: 106
      prefix: --ambiguous-nucl
  - id: case_sensitive
    type:
      - 'null'
      - boolean
    doc: "Do NOT ignore case distinctions (ignored by default)"
    inputBinding:
      position: 107
      prefix: --case-sensitive
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: "Print non-matching entries"
    inputBinding:
      position: 108
      prefix: --invert-match
  - id: only_matching
    type:
      - 'null'
      - boolean
    doc: "Show only the part that matches"
    inputBinding:
      position: 109
      prefix: --only-matching
  - id: before_context
    type:
      - 'null'
      - int
    doc: "Include N characters before match"
    inputBinding:
      position: 110
      prefix: --before-context
  - id: after_context
    type:
      - 'null'
      - int
    doc: "Include N characters after match"
    inputBinding:
      position: 111
      prefix: --after-context
  - id: context
    type:
      - 'null'
      - int
    doc: "Include N characters before and after match"
    inputBinding:
      position: 112
      prefix: --context
  - id: count
    type:
      - 'null'
      - boolean
    doc: "Print number of entries with matches"
    inputBinding:
      position: 113
      prefix: --count
  - id: count_matches
    type:
      - 'null'
      - boolean
    doc: "Print number of non-overlapping matches"
    inputBinding:
      position: 114
      prefix: --count-matches
  - id: line_regexp
    type:
      - 'null'
      - boolean
    doc: "Force PATTERN to match the whole text (regex allowed)"
    inputBinding:
      position: 115
      prefix: --line-regexp
  - id: exact
    type:
      - 'null'
      - boolean
    doc: "Force PATTERN to literally equal the text (fast)"
    inputBinding:
      position: 116
      prefix: --exact
  - id: gapped
    type:
      - 'null'
      - boolean
    doc: "Match across gaps when searching aligned sequences"
    inputBinding:
      position: 117
      prefix: --gapped
  - id: both_strands
    type:
      - 'null'
      - boolean
    doc: "Search both strands"
    inputBinding:
      position: 118
      prefix: --both-strands
  - id: reverse_only
    type:
      - 'null'
      - boolean
    doc: "Only search the reverse strand"
    inputBinding:
      position: 119
      prefix: --reverse-only
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: "Do not print in color"
    inputBinding:
      position: 120
      prefix: --no-color
  - id: force_color
    type:
      - 'null'
      - boolean
    doc: "Print in color even to non-tty (DANGEROUS)"
    inputBinding:
      position: 121
      prefix: --force-color
  - id: preserve_color
    type:
      - 'null'
      - boolean
    doc: "Preserve incoming color"
    inputBinding:
      position: 122
      prefix: --preserve-color
  - id: color
    type:
      - 'null'
      - string
    doc: "Choose a highlight color"
    inputBinding:
      position: 123
      prefix: --color
  - id: gff
    type:
      - 'null'
      - boolean
    doc: "Output matches in gff format"
    inputBinding:
      position: 124
      prefix: --gff
  - id: gff_type
    type:
      - 'null'
      - string
    doc: "Name of searched feature"
    inputBinding:
      position: 125
      prefix: --gff-type
  - id: fastain
    type:
      - 'null'
      - File
    doc: "Search for exact sequence matches against this FASTA file"
    inputBinding:
      position: 126
      prefix: --fastain
  - id: input_file
    type: File
    doc: "Input FASTA file (smof reads standard input by default)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_grep.out
