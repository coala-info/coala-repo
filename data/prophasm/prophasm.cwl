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
    doc: Input FASTA file (can be used multiple times).
    inputBinding:
      position: 101
      prefix: -i
  - id: intersection_file
    type:
      - 'null'
      - File
    doc: Compute intersection, subtract it, save it.
    inputBinding:
      position: 101
      prefix: -x
  - id: kmer_size
    type: int
    doc: K-mer size.
    inputBinding:
      position: 101
      prefix: -k
  - id: silent_mode
    type:
      - 'null'
      - boolean
    doc: Silent mode.
    inputBinding:
      position: 101
      prefix: -S
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Output file with k-mer statistics.
    inputBinding:
      position: 101
      prefix: -s
  - id: output_files_path
    type: string
    doc: Output or path parameter `output_files_path`
    inputBinding:
      position: 102
      prefix: --output-files
outputs:
  - id: output_files
    type:
      - 'null'
      - File
    doc: Output FASTA file (if used, must be used as many times as -i).
    outputBinding:
      glob: $(inputs.output_files_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophasm:0.1.1--h077b44d_5
