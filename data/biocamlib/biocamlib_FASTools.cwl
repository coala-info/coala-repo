cwlVersion: v1.2
class: CommandLineTool
baseCommand: FASTools
label: biocamlib_FASTools
doc: "A tool for processing FASTA/FASTQ records, including conversion to tabular format,
  sequence matching, reverse-complementing, and quality dropping.\n\nTool homepage:
  https://github.com/PaoloRibeca/BiOCamLib"
inputs:
  - id: compact
    type:
      - 'null'
      - boolean
    doc: put each FASTA/FASTQ record on one tab-separated line
    inputBinding:
      position: 101
      prefix: --compact
  - id: dropq
    type:
      - 'null'
      - boolean
    doc: drop qualities in FASTA/FASTQ records or tab-separated lines
    inputBinding:
      position: 101
      prefix: --dropq
  - id: expand
    type:
      - 'null'
      - boolean
    doc: split each tab-separated line into one or more FASTA/FASTQ records
    inputBinding:
      position: 101
      prefix: --expand
  - id: fasta
    type:
      - 'null'
      - File
    doc: process FASTA input file containing sequences
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fasta_stdin
    type:
      - 'null'
      - boolean
    doc: process FASTA sequences from standard input
    inputBinding:
      position: 101
      prefix: -F
  - id: flush
    type:
      - 'null'
      - boolean
    doc: flush output after each record (global option)
    inputBinding:
      position: 101
      prefix: --flush
  - id: interleaved_stdin
    type:
      - 'null'
      - boolean
    doc: process interleaved FASTQ sequencing reads from standard input
    inputBinding:
      position: 101
      prefix: -P
  - id: linter
    type:
      - 'null'
      - string
    doc: sets linter for sequence ('none'|'DNA'|'dna'|'protein'). All non-base/non-AA
      characters are converted to unknowns
    default: none
    inputBinding:
      position: 101
      prefix: --linter
  - id: linter_keep_dashes
    type:
      - 'null'
      - boolean
    doc: sets whether the linter should keep dashes appearing in sequences rather
      than convert them to unknowns
    default: false
    inputBinding:
      position: 101
      prefix: --linter-keep-dashes
  - id: linter_keep_lowercase
    type:
      - 'null'
      - boolean
    doc: sets whether the linter should keep lowercase DNA/protein characters appearing
      in sequences rather than capitalise them
    default: false
    inputBinding:
      position: 101
      prefix: --linter-keep-lowercase
  - id: match
    type:
      - 'null'
      - string
    doc: select matching sequence names in FASTA/FASTQ records or tab-separated lines
      using a regular expression
    inputBinding:
      position: 101
      prefix: --match
  - id: paired_end
    type:
      - 'null'
      - type: array
        items: File
    doc: process FASTQ input files containing paired-end sequencing reads (expects
      two files)
    inputBinding:
      position: 101
      prefix: --paired-end
  - id: revcom
    type:
      - 'null'
      - boolean
    doc: reverse-complement sequences in FASTA/FASTQ records or tab-separated lines
    inputBinding:
      position: 101
      prefix: --revcom
  - id: single_end
    type:
      - 'null'
      - File
    doc: process FASTQ input file containing single-end sequencing reads
    inputBinding:
      position: 101
      prefix: --single-end
  - id: single_end_stdin
    type:
      - 'null'
      - boolean
    doc: process single-end FASTQ sequencing reads from standard input
    inputBinding:
      position: 101
      prefix: -S
  - id: tabular
    type:
      - 'null'
      - File
    doc: process input file containing FAST[A|Q] records as tab-separated lines
    inputBinding:
      position: 101
      prefix: --tabular
  - id: tabular_stdin
    type:
      - 'null'
      - boolean
    doc: process FAST[A|Q] records in tabular form from standard input
    inputBinding:
      position: 101
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: set verbose execution (global option)
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: set the name of the output file
    outputBinding:
      glob: $(inputs.output)
  - id: paired_end_output
    type:
      - 'null'
      - File
    doc: set the names of paired-end FASTQ output files (expects two files)
    outputBinding:
      glob: $(inputs.paired_end_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocamlib:1.0.0--h9ee0642_0
