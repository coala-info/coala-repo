cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhblits
label: hhsuite_hhblits
doc: "The provided text does not contain help information for hhblits; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
stdout: hhsuite_hhblits.out
