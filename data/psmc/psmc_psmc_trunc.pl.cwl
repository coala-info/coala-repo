cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psmc_trunc.pl
label: psmc_psmc_trunc.pl
doc: "Truncate a PSMC result file at a given time\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: input_psmc
    type: File
    doc: "PSMC result file"
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
  - id: d
    type:
      - 'null'
      - float
    doc: "Truncation time (default: 0)"
    inputBinding:
      position: 2
      prefix: "-d"
  - id: s
    type:
      - 'null'
      - int
    doc: "Skip used in the psmc run (default: 100)"
    inputBinding:
      position: 3
      prefix: "-s"
outputs:
  - id: truncated
    type: stdout
    doc: "Truncated PSMC file"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: trunc.psmc
