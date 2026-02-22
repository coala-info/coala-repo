cwlVersion: v1.2
class: CommandLineTool
baseCommand: biocantor
label: biocantor
doc: "The provided text does not contain a description of the tool; it contains error
  messages related to a container execution failure.\n\nTool homepage: https://github.com/ifiddes/BioCantor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocantor:1.3.0--pyh7e72e81_0
stdout: biocantor.out
