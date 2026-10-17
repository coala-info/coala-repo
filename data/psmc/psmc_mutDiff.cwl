cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mutDiff
label: psmc_mutDiff
doc: "Count mutation differences between two sequences relative to an outgroup\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: fasta_1
    type: File
    doc: "First sequence (1.fa)"
    inputBinding:
      position: 100
  - id: fasta_2
    type: File
    doc: "Second sequence (2.fa)"
    inputBinding:
      position: 101
  - id: outgroup
    type: File
    doc: "Outgroup sequence (outgroup.fa)"
    inputBinding:
      position: 102
  - id: binary
    type:
      - 'null'
      - boolean
    doc: "Binary output"
    inputBinding:
      position: 1
      prefix: "-b"
  - id: l_option
    type:
      - 'null'
      - boolean
    doc: "Option -l of mutDiff (listed in the help as [-bl])"
    inputBinding:
      position: 2
      prefix: "-l"
  - id: window
    type:
      - 'null'
      - int
    doc: "Window option -w of mutDiff (not shown in the usage line)"
    inputBinding:
      position: 3
      prefix: "-w"
  - id: step
    type:
      - 'null'
      - int
    doc: "Step size (default: 100)"
    inputBinding:
      position: 4
      prefix: "-s"
outputs:
  - id: result
    type: stdout
    doc: "Mutation difference output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: mutDiff.out
