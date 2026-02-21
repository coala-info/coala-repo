cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat2
label: mercat2
doc: "The provided text does not contain help information for mercat2; it contains
  system error messages regarding a failed container build due to insufficient disk
  space.\n\nTool homepage: https://github.com/raw-lab/mercat2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat2:1.4.1--pyhdfd78af_0
stdout: mercat2.out
