cwlVersion: v1.2
class: CommandLineTool
baseCommand: salmon quant
label: salmon_quant
doc: "Quantifies expression using raw reads or already-aligned reads (in BAM/SAM format).\n\
  \nTool homepage: https://github.com/COMBINE-lab/salmon"
inputs:
  - id: alignments
    type:
      - 'null'
      - File
    doc: Use the alignment-based algorithm for quantifying from reads.
    inputBinding:
      position: 101
      prefix: --alignments
  - id: help_alignment
    type:
      - 'null'
      - boolean
    doc: View the help for salmon's alignment-based mode.
    inputBinding:
      position: 101
      prefix: --help-alignment
  - id: help_reads
    type:
      - 'null'
      - boolean
    doc: View the help for salmon's selective-alignment-based mode.
    inputBinding:
      position: 101
      prefix: --help-reads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/salmon:1.10.3--h45fbf2d_5
stdout: salmon_quant.out
