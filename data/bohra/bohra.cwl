cwlVersion: v1.2
class: CommandLineTool
baseCommand: bohra
label: bohra
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log related to a failed container execution (no space left
  on device).\n\nTool homepage: https://github.com/kristyhoran/bohra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bohra:3.3.0--pyhdfd78af_0
stdout: bohra.out
