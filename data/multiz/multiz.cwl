cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiz.v11.2
label: multiz
doc: "aligning two files of alignment blocks where top rows are always the reference,
  reference in both files cannot have duplicats\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: file1
    type: File
    doc: First alignment block file
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: Second alignment block file
    inputBinding:
      position: 2
  - id: all_blocks
    type:
      - 'null'
      - boolean
    doc: Output all blocks, including single-row blocks
    default: false
    inputBinding:
      position: 103
  - id: minimum_output_width
    type:
      - 'null'
      - int
    doc: minimum output width.
    default: 1
    inputBinding:
      position: 103
      prefix: -M
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not output MAF header
    default: false
    inputBinding:
      position: 103
  - id: radius
    type:
      - 'null'
      - int
    doc: radius in dynamic programming.
    default: 30
    inputBinding:
      position: 103
      prefix: -R
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output flag
    inputBinding:
      position: 103
outputs:
  - id: out1
    type:
      - 'null'
      - File
    doc: File name for collecting unused input from file1
    outputBinding:
      glob: $(inputs.out1)
  - id: out2
    type:
      - 'null'
      - File
    doc: File name for collecting unused input from file2
    outputBinding:
      glob: $(inputs.out2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
