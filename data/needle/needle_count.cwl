cwlVersion: v1.2
class: CommandLineTool
baseCommand: needle-count
label: needle_count
doc: "Get expression value depending on minimizers. This function is only used to
  test the validity of Needle's estimation approach. It estimates the expression value
  for all sequences in the genome file based on the exact minimiser occurrences of
  the given sequence files.\n\nTool homepage: https://github.com/seqan/needle"
inputs:
  - id: argument_1
    type:
      type: array
      items: File
    doc: List of sequence files. Please provide at least one sequence file.
    inputBinding:
      position: 1
  - id: advanced_help
    type:
      - 'null'
      - boolean
    doc: Prints the help page including advanced options.
    inputBinding:
      position: 102
      prefix: --advanced-help
  - id: copyright
    type:
      - 'null'
      - boolean
    doc: Prints the copyright/license information.
    inputBinding:
      position: 102
      prefix: --copyright
  - id: exclude
    type:
      - 'null'
      - File
    doc: Please provide one sequence file with minimizers to ignore.
    default: ''
    inputBinding:
      position: 102
      prefix: --exclude
  - id: export_help
    type:
      - 'null'
      - string
    doc: Export the help page information. Value must be one of [html, man].
    inputBinding:
      position: 102
      prefix: --export-help
  - id: genome
    type:
      - 'null'
      - File
    doc: Please provide one sequence file with transcripts.
    default: ''
    inputBinding:
      position: 102
      prefix: --genome
  - id: kmer
    type:
      - 'null'
      - int
    doc: Define k-mer size for the minimisers.
    default: 20
    inputBinding:
      position: 102
      prefix: --kmer
  - id: out
    type:
      - 'null'
      - Directory
    doc: Directory, where output files should be saved.
    default: ./
    inputBinding:
      position: 102
      prefix: --out
  - id: paired
    type:
      - 'null'
      - boolean
    doc: If set, experiments are paired.
    inputBinding:
      position: 102
      prefix: --paired
  - id: seed
    type:
      - 'null'
      - int
    doc: Define seed for the minimisers.
    default: 0
    inputBinding:
      position: 102
      prefix: --seed
  - id: shape
    type:
      - 'null'
      - int
    doc: Define a shape for the minimisers by the decimal of a bitvector, where 
      0 symbolizes a position to be ignored, 1 a position considered.
    default: 0
    inputBinding:
      position: 102
      prefix: --shape
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: window
    type:
      - 'null'
      - int
    doc: Define window size for the minimisers.
    default: 60
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
stdout: needle_count.out
