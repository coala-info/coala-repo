cwlVersion: v1.2
class: CommandLineTool
baseCommand: dgenies
label: dgenies
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: http://dgenies.toulouse.inra.fr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dgenies:1.5.0--pyhdfd78af_1
stdout: dgenies.out
