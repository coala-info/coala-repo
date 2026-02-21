cwlVersion: v1.2
class: CommandLineTool
baseCommand: imorph
label: imods_imorph
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image creation (no space left on device).\n\nTool homepage: https://chaconlab.org/multiscale-simulations/imod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imods:1.0.4--h9ee0642_3
stdout: imods_imorph.out
