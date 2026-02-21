cwlVersion: v1.2
class: CommandLineTool
baseCommand: rpbasicdesign
label: rpbasicdesign
doc: "The provided text does not contain a description of the tool as it appears to
  be an error log from a container build process.\n\nTool homepage: https://github.com/conda-forge/rpbasicdesign-feedstock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rpbasicdesign:1.2.2
stdout: rpbasicdesign.out
