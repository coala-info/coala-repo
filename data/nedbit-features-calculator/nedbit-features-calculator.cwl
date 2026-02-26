cwlVersion: v1.2
class: CommandLineTool
baseCommand: nedbit-features-calculator
label: nedbit-features-calculator
doc: "Calculate features from a file link and gene file, and output to a file.\n\n\
  Tool homepage: https://github.com/AndMastro/NIAPU"
inputs:
  - id: filelink
    type: File
    doc: Input file link
    inputBinding:
      position: 1
  - id: filegene
    type: File
    doc: Input gene file
    inputBinding:
      position: 2
outputs:
  - id: fileout
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nedbit-features-calculator:1.2--h031d066_0
