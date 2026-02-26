cwlVersion: v1.2
class: CommandLineTool
baseCommand: sdm
label: sdm
doc: "sdm (simple demultiplexer) is a fast, memory efficient program to demultiplex
  fasta and fastq files or simply do quality filterings on these.\n\nTool homepage:
  https://github.com/hildebra/sdm/"
inputs:
  - id: help_flags
    type:
      - 'null'
      - boolean
    doc: help on command line (flags) arguments for sdm
    inputBinding:
      position: 101
      prefix: -help_flags
  - id: help_map
    type:
      - 'null'
      - boolean
    doc: base_map files and the keywords for barcodes etc.
    inputBinding:
      position: 101
      prefix: -help_map
  - id: help_options
    type:
      - 'null'
      - boolean
    doc: print help on configuring options files
    inputBinding:
      position: 101
      prefix: -help_options
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sdm:3.11--h077b44d_0
stdout: sdm.out
