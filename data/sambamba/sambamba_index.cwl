cwlVersion: v1.2
class: CommandLineTool
baseCommand: sambamba-index
label: sambamba_index
doc: "Creates index for a BAM, or FASTA file\n\nTool homepage: https://github.com/biod/sambamba"
inputs:
  - id: input_file
    type: File
    doc: Input BAM or FASTA file
    inputBinding:
      position: 1
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output index file
    inputBinding:
      position: 2
  - id: check_bins
    type:
      - 'null'
      - boolean
    doc: check that bins are set correctly
    inputBinding:
      position: 103
      prefix: --check-bins
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: specify that input is in FASTA format
    inputBinding:
      position: 103
      prefix: --fasta-input
  - id: nthreads
    type:
      - 'null'
      - int
    doc: number of threads to use for decompression
    inputBinding:
      position: 103
      prefix: --nthreads
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: show progress bar in STDERR
    inputBinding:
      position: 103
      prefix: --show-progress
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
stdout: sambamba_index.out
