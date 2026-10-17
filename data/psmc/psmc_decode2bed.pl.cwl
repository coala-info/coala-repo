cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - decode2bed.pl
label: psmc_decode2bed.pl
doc: "Convert PSMC decoding output to BED\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: input_dec
    type: File
    doc: "Decoding output (.dec) of psmc -d"
    inputBinding:
      position: 100
  - id: s
    type:
      - 'null'
      - int
    doc: "Skip used in the psmc run (default: 100)"
    inputBinding:
      position: 1
      prefix: "-s"
  - id: N
    type:
      - 'null'
      - int
    doc: "Option -N of decode2bed.pl"
    inputBinding:
      position: 2
      prefix: "-N"
  - id: u
    type:
      - 'null'
      - float
    doc: "Mutation rate option -u"
    inputBinding:
      position: 3
      prefix: "-u"
outputs:
  - id: bed
    type: stdout
    doc: "BED intervals"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: decode.bed
