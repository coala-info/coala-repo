cwlVersion: v1.2
class: CommandLineTool
baseCommand: pardre
label: pardre
doc: "The provided text does not contain help information or a description of the
  tool; it consists of system error messages regarding disk space and container image
  retrieval.\n\nTool homepage: https://sourceforge.net/projects/pardre/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pardre:2.2.5--h2aad775_4
stdout: pardre.out
