cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta_splitter
label: fasta_windows
doc: "Splits a FASTA file into smaller files.\n\nTool homepage: https://github.com/tolkit/fasta_windows"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 2
  - id: lines_per_file
    type:
      - 'null'
      - int
    doc: Number of lines per output file
    inputBinding:
      position: 103
      prefix: --lines-per-file
  - id: num_files
    type:
      - 'null'
      - int
    doc: Number of output files to create
    inputBinding:
      position: 103
      prefix: --num-files
  - id: seqs_per_file
    type:
      - 'null'
      - int
    doc: Number of sequences per output file
    inputBinding:
      position: 103
      prefix: --seqs-per-file
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save output files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta-splitter:0.2.6--0
