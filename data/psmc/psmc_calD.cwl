cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - calD
label: psmc_calD
doc: "Calculate the D-statistic (ABBA-BABA style test) from four consensus sequences\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: u_fasta
    type: File
    doc: "U.fa"
    inputBinding:
      position: 100
  - id: v_fasta
    type: File
    doc: "V.fa"
    inputBinding:
      position: 101
  - id: x_fasta
    type: File
    doc: "X.fa"
    inputBinding:
      position: 102
  - id: y_fasta
    type: File
    doc: "Y.fa"
    inputBinding:
      position: 103
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Window size for block Jack-Knife (default: 1000000)"
    inputBinding:
      position: 1
      prefix: "-w"
  - id: quality
    type:
      - 'null'
      - int
    doc: "Quality threshold (default: 0)"
    inputBinding:
      position: 2
      prefix: "-q"
  - id: mask_bed
    type:
      - 'null'
      - File
    doc: "Mask regions in this BED file"
    inputBinding:
      position: 3
      prefix: "-M"
  - id: step
    type:
      - 'null'
      - int
    doc: "Step size, effective with -b (default: 100)"
    inputBinding:
      position: 4
      prefix: "-s"
  - id: binary
    type:
      - 'null'
      - boolean
    doc: "Binary output"
    inputBinding:
      position: 5
      prefix: "-b"
  - id: three
    type:
      - 'null'
      - boolean
    doc: "Three-sequence mode (-3)"
    inputBinding:
      position: 6
      prefix: "-3"
outputs:
  - id: result
    type: stdout
    doc: "D-statistic output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: calD.out
