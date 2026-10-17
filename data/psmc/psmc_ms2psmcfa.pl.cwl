cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ms2psmcfa.pl
label: psmc_ms2psmcfa.pl
doc: "Convert ms simulation output to PSMCFA\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: input_ms
    type: File
    doc: "ms simulation output"
    inputBinding:
      position: 100
  - id: s
    type:
      - 'null'
      - int
    doc: "Bin size (default: 100)"
    inputBinding:
      position: 1
      prefix: "-s"
outputs:
  - id: psmcfa
    type: stdout
    doc: "PSMCFA sequence"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: ms.psmcfa
