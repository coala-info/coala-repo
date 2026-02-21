cwlVersion: v1.2
class: CommandLineTool
baseCommand: pb-falcon-phase
label: pb-falcon-phase
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed execution attempt where the executable was not found.\n
  \nTool homepage: https://github.com/PacificBiosciences/pb-falcon-phase"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pb-falcon-phase:0.1.0--h3889886_0
stdout: pb-falcon-phase.out
