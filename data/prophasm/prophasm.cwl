cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophasm
label: prophasm
doc: "a greedy assembler for k-mer set compression\n\nTool homepage: https://github.com/prophyle/prophasm"
inputs:
  - id: input_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: -i
        separate: true
    doc: Input FASTA file (can be used multiple times).
    inputBinding:
      position: 101
  - id: intersection_file
    type:
      - 'null'
      - string
    doc: Compute intersection, subtract it, save it (output FASTA file name).
    inputBinding:
      position: 102
      prefix: -x
  - id: kmer_size
    type: int
    doc: K-mer size.
    inputBinding:
      position: 100
      prefix: -k
  - id: output_files
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -o
          separate: true
    doc: Output FASTA file (if used, must be used as many times as -i).
    inputBinding:
      position: 103
  - id: silent_mode
    type:
      - 'null'
      - boolean
    doc: Silent mode.
    inputBinding:
      position: 104
      prefix: -S
  - id: stats_file
    type:
      - 'null'
      - string
    doc: Output file with k-mer statistics.
    inputBinding:
      position: 105
      prefix: -s
outputs:
  - id: output_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: Output FASTA files (-o)
    outputBinding:
      glob: $(inputs.output_files)
  - id: intersection_out
    type:
      - 'null'
      - File
    doc: Intersection FASTA file (-x)
    outputBinding:
      glob: $(inputs.intersection_file)
  - id: stats_file_out
    type:
      - 'null'
      - File
    doc: Output file with k-mer statistics.
    outputBinding:
      glob: $(inputs.stats_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophasm:0.1.1--h077b44d_5
