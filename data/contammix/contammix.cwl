cwlVersion: v1.2
class: CommandLineTool
baseCommand: contammix
label: contammix
doc: "The provided text does not contain help information for the tool; it consists
  of error messages related to a container execution failure (no space left on device).\n\
  \nTool homepage: https://github.com/plfjohnson/contamMix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contammix:1.0.11--r45h28c4f14_5
stdout: contammix.out
