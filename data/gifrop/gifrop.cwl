cwlVersion: v1.2
class: CommandLineTool
baseCommand: gifrop
label: gifrop
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure.\n\nTool homepage:
  https://github.com/jtrachsel/gifrop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gifrop:0.0.9--hdfd78af_0
stdout: gifrop.out
