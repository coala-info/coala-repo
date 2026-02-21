cwlVersion: v1.2
class: CommandLineTool
baseCommand: tagra_go.py
label: tagra_go.py
doc: "The provided text does not contain help information or argument descriptions;
  it is an error log from a container build process.\n\nTool homepage: https://github.com/davidetorre92/TaGra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tagra:0.2.5--pyhdfd78af_0
stdout: tagra_go.py.out
