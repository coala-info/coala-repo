cwlVersion: v1.2
class: CommandLineTool
baseCommand: imods_imove
label: imods_imove
doc: "The provided text does not contain help information for the tool; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://chaconlab.org/multiscale-simulations/imod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imods:1.0.4--h9ee0642_3
stdout: imods_imove.out
