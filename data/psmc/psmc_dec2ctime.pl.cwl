cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dec2ctime.pl
label: psmc_dec2ctime.pl
doc: "Convert PSMC decoding output to coalescent times along the genome\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: input_dec
    type: File
    doc: "Decoding output (.dec) of psmc -d"
    inputBinding:
      position: 100
  - id: u
    type:
      - 'null'
      - float
    doc: "Mutation rate"
    inputBinding:
      position: 1
      prefix: "-u"
  - id: s
    type:
      - 'null'
      - int
    doc: "Skip used in the psmc run (default: 100)"
    inputBinding:
      position: 2
      prefix: "-s"
  - id: N
    type:
      - 'null'
      - int
    doc: "Option -N of dec2ctime.pl"
    inputBinding:
      position: 3
      prefix: "-N"
  - id: r
    type:
      - 'null'
      - boolean
    doc: "Random generation"
    inputBinding:
      position: 4
      prefix: "-r"
outputs:
  - id: ctime
    type: stdout
    doc: "Coalescent times"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: dec2ctime.txt
