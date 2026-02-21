cwlVersion: v1.2
class: CommandLineTool
baseCommand: imods_imc
label: imods_imc
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains error logs related to a container environment failure (no
  space left on device).\n\nTool homepage: https://chaconlab.org/multiscale-simulations/imod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imods:1.0.4--h9ee0642_3
stdout: imods_imc.out
