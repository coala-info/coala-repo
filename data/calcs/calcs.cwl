cwlVersion: v1.2
class: CommandLineTool
baseCommand: calcs
label: calcs
doc: "Calculate consensus sequences from BAM/SAM files.\n\nTool homepage: https://github.com/akikuno/calcs"
inputs:
  - id: input_sam
    type:
      - 'null'
      - File
    doc: Give the full path to a SAM file
    inputBinding:
      position: 1
  - id: long_format
    type:
      - 'null'
      - boolean
    doc: Output the cs tag in the long form
    inputBinding:
      position: 102
      prefix: --long
  - id: paf_output
    type:
      - 'null'
      - boolean
    doc: Output PAF
    inputBinding:
      position: 102
      prefix: --paf
  - id: reference
    type: File
    doc: Give the full path to a reference FASTA file
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calcs:0.0.0.9999--pyh5e36f6f_0
stdout: calcs.out
