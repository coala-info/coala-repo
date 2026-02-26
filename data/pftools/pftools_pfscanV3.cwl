cwlVersion: v1.2
class: CommandLineTool
baseCommand: pfscanV3
label: pftools_pfscanV3
doc: "Scan a protein sequence with a profile library\n\nTool homepage: https://web.expasy.org/pftools/"
inputs:
  - id: profiles
    type: File
    doc: Profile library
    inputBinding:
      position: 1
  - id: sequences
    type:
      type: array
      items: File
    doc: Sequences to scan
    inputBinding:
      position: 2
  - id: database_index
    type:
      - 'null'
      - File
    doc: use indices stored in given file
    inputBinding:
      position: 103
      prefix: --database-index
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: FASTA file database as input
    inputBinding:
      position: 103
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: FASTQ file database as input
    inputBinding:
      position: 103
      prefix: --fastq
  - id: filter_normalized_cutoff
    type:
      - 'null'
      - float
    doc: filter normalized cutoff value
    inputBinding:
      position: 103
      prefix: --filter-normalized-cutoff
  - id: level
    type:
      - 'null'
      - int
    doc: level to use for cutoff
    default: 0
    inputBinding:
      position: 103
      prefix: --level
  - id: matrix_only
    type:
      - 'null'
      - boolean
    doc: only matrix profile will be treated
    inputBinding:
      position: 103
      prefix: --matrix-only
  - id: max_heuristic_nthreads
    type:
      - 'null'
      - string
    doc: max number of threads to use for heuristic phase only. (IO bounds)
    inputBinding:
      position: 103
      prefix: --max-heuristic-nthreads
  - id: max_regex_match
    type:
      - 'null'
      - string
    doc: maximum number of returned matches per sequence
    default: 16
    inputBinding:
      position: 103
      prefix: --max-regex-match
  - id: mode
    type:
      - 'null'
      - int
    doc: mode to use for normalization
    default: 1
    inputBinding:
      position: 103
      prefix: --mode
  - id: no_heuristic
    type:
      - 'null'
      - boolean
    doc: bypass heuristic
    inputBinding:
      position: 103
      prefix: --no-heuristic
  - id: nthreads
    type:
      - 'null'
      - string
    doc: max number of threads to use
    inputBinding:
      position: 103
      prefix: --nthreads
  - id: output_length
    type:
      - 'null'
      - string
    doc: maximum number of column for sequence output printing
    default: 60
    inputBinding:
      position: 103
      prefix: --output-length
  - id: output_method
    type:
      - 'null'
      - string
    doc: printing output method
    default: 5
    inputBinding:
      position: 103
      prefix: --output-method
  - id: pattern_only
    type:
      - 'null'
      - boolean
    doc: only pattern profile will be treated
    inputBinding:
      position: 103
      prefix: --pattern-only
  - id: sse2
    type:
      - 'null'
      - boolean
    doc: enforces SSE 2 only instruction set, default to using SSE 4.1
    inputBinding:
      position: 103
      prefix: --sse2
  - id: unknown_symbol
    type:
      - 'null'
      - string
    doc: change unknown symbol to given character
    inputBinding:
      position: 103
      prefix: --unknown-synbol
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose on stderr
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pftools:3.2.13--pl5321r44hcf78210_0
stdout: pftools_pfscanV3.out
