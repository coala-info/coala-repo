cwlVersion: v1.2
class: CommandLineTool
baseCommand: imods_imode
label: imods_imode
doc: "Internal Normal Mode Analysis (iMODS) tool for protein flexibility analysis.\n
  \nTool homepage: https://chaconlab.org/multiscale-simulations/imod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imods:1.0.4--h9ee0642_3
stdout: imods_imode.out
