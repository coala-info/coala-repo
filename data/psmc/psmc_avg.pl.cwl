cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - avg.pl
label: psmc_avg.pl
doc: "Compute average population size over time intervals from a PSMC result\n\nTool homepage: https://github.com/lh3/psmc"
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
  - id: s
    type:
      - 'null'
      - int
    doc: "Skip used in the psmc run (default: 100)"
    inputBinding:
      position: 2
      prefix: "-s"
  - id: b
    type:
      - 'null'
      - float
    doc: "Option -b (begin; default: 0)"
    inputBinding:
      position: 3
      prefix: "-b"
  - id: e
    type:
      - 'null'
      - float
    doc: "Option -e (end; default: 999)"
    inputBinding:
      position: 4
      prefix: "-e"
outputs:
  - id: result
    type: stdout
    doc: "Average table"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: avg.txt
