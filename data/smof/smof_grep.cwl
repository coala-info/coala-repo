cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_grep
label: smof_grep
doc: "Smof grep is based on GNU grep but operates on fasta entries. It allows you
  to extract entries where either the header or the sequence match the search term.
  For sequence searches, it can produce GFF formatted output, which specifies the
  location of each match.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: pattern
    type: string
    doc: pattern to match
    inputBinding:
      position: 1
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence (default = stdin)
    default: stdin
    inputBinding:
      position: 2
  - id: after_context
    type:
      - 'null'
      - int
    doc: Include N characters after match
    inputBinding:
      position: 103
      prefix: --after-context
  - id: ambiguous_nucleotide
    type:
      - 'null'
      - boolean
    doc: parse extended nucleotide alphabet
    inputBinding:
      position: 103
      prefix: --ambiguous-nucl
  - id: before_context
    type:
      - 'null'
      - int
    doc: Include N characters before match
    inputBinding:
      position: 103
      prefix: --before-context
  - id: both_strands
    type:
      - 'null'
      - boolean
    doc: search both strands
    inputBinding:
      position: 103
      prefix: --both-strands
  - id: case_sensitive
    type:
      - 'null'
      - boolean
    doc: DO NOT ignore case distinctions (ignore by default)
    inputBinding:
      position: 103
      prefix: --case-sensitive
  - id: color
    type:
      - 'null'
      - string
    doc: Choose a highlight color
    inputBinding:
      position: 103
      prefix: --color
  - id: context
    type:
      - 'null'
      - int
    doc: Include N characters before and after match
    inputBinding:
      position: 103
      prefix: --context
  - id: count
    type:
      - 'null'
      - boolean
    doc: print number of entries with matches
    inputBinding:
      position: 103
      prefix: --count
  - id: count_matches
    type:
      - 'null'
      - boolean
    doc: print number of non-overlapping matches
    inputBinding:
      position: 103
      prefix: --count-matches
  - id: exact
    type:
      - 'null'
      - boolean
    doc: force PATTERN to literally equal the text (fast)
    inputBinding:
      position: 103
      prefix: --exact
  - id: files_with_matches
    type:
      - 'null'
      - boolean
    doc: print names input files with matches
    inputBinding:
      position: 103
      prefix: --files-with-matches
  - id: files_without_match
    type:
      - 'null'
      - boolean
    doc: print names files with no matches
    inputBinding:
      position: 103
      prefix: --files-without-match
  - id: force_color
    type:
      - 'null'
      - boolean
    doc: print in color even to non-tty (DANGEROUS)
    inputBinding:
      position: 103
      prefix: --force-color
  - id: gapped
    type:
      - 'null'
      - boolean
    doc: match across gaps when searching aligned sequences
    inputBinding:
      position: 103
      prefix: --gapped
  - id: gff
    type:
      - 'null'
      - boolean
    doc: output matches in gff format
    inputBinding:
      position: 103
      prefix: --gff
  - id: gff_type
    type:
      - 'null'
      - string
    doc: name of searched feature
    inputBinding:
      position: 103
      prefix: --gff-type
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: print non-matching entries
    inputBinding:
      position: 103
      prefix: --invert-match
  - id: line_regexp
    type:
      - 'null'
      - boolean
    doc: force PATTERN to match the whole text (regex allowed)
    inputBinding:
      position: 103
      prefix: --line-regexp
  - id: match_sequence
    type:
      - 'null'
      - boolean
    doc: match sequence rather than header
    inputBinding:
      position: 103
      prefix: --match-sequence
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: do not print in color
    inputBinding:
      position: 103
      prefix: --no-color
  - id: only_matching
    type:
      - 'null'
      - boolean
    doc: show only the part that matches
    inputBinding:
      position: 103
      prefix: --only-matching
  - id: pattern_file
    type:
      - 'null'
      - File
    doc: obtain patterns from FILE, one per line
    inputBinding:
      position: 103
      prefix: --file
  - id: perl_regexp
    type:
      - 'null'
      - boolean
    doc: treat patterns as perl regular expressions
    inputBinding:
      position: 103
      prefix: --perl-regexp
  - id: preserve_color
    type:
      - 'null'
      - boolean
    doc: Preserve incoming color
    inputBinding:
      position: 103
      prefix: --preserve-color
  - id: reverse_only
    type:
      - 'null'
      - boolean
    doc: only search the reverse strand
    inputBinding:
      position: 103
      prefix: --reverse-only
  - id: search_fasta
    type:
      - 'null'
      - File
    doc: Search for exact sequence matches against FASTA
    inputBinding:
      position: 103
      prefix: --fastain
  - id: wrap_regex
    type:
      - 'null'
      - string
    doc: a regular expression to capture patterns
    inputBinding:
      position: 103
      prefix: --wrap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_grep.out
