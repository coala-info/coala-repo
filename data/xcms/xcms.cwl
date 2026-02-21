cwlVersion: v1.2
class: CommandLineTool
baseCommand: xcms
label: xcms
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log reporting a failure to build or fetch a container
  image.\n\nTool homepage: https://github.com/beixiaocai/xcms"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/xcms:phenomenal-v1.52.0_cv0.7.63
stdout: xcms.out
