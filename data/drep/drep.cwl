cwlVersion: v1.2
class: CommandLineTool
baseCommand: drep
label: drep
doc: "The provided text does not contain help information or a description of the
  tool; it contains error messages related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/MrOlm/drep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drep:3.6.2--pyhdfd78af_0
stdout: drep.out
