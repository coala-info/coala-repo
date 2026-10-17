cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psmc2history.pl
label: psmc_psmc2history.pl
doc: "Convert a PSMC result to a history file for simulation\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: input_psmc_par
    type: File
    doc: "PSMC output file (.psmc or .par)"
    inputBinding:
      position: 100
  - id: n
    type:
      - 'null'
      - int
    doc: "Iteration number (default: 20)"
    inputBinding:
      position: 1
      prefix: "-n"
  - id: u
    type:
      - 'null'
      - float
    doc: "Mutation rate"
    inputBinding:
      position: 2
      prefix: "-u"
outputs:
  - id: history
    type: stdout
    doc: "History file"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: history.txt
