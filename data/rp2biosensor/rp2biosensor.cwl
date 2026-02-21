cwlVersion: v1.2
class: CommandLineTool
baseCommand: rp2biosensor
label: rp2biosensor
doc: "rp2biosensor (Note: The provided text is a container build error log and does
  not contain help documentation or argument definitions).\n\nTool homepage: https://github.com/conda-forge/rp2biosensor-feedstock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rp2biosensor:3.2.1
stdout: rp2biosensor.out
