cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhmake
label: hhsuite_hhmake
doc: "Build an HMM from an input alignment or convert between HMM formats (Note: The
  provided text contains only system error messages and no help documentation; therefore,
  no arguments could be extracted).\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
stdout: hhsuite_hhmake.out
