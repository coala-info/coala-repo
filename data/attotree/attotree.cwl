cwlVersion: v1.2
class: CommandLineTool
baseCommand: attotree
label: attotree
doc: "The provided text does not contain help information or a description of the
  tool; it consists of system error messages related to a Singularity/Docker container
  execution failure (no space left on device).\n\nTool homepage: https://github.com/karel-brinda/attotree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/attotree:0.1.6--pyhdfd78af_0
stdout: attotree.out
