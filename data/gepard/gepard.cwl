cwlVersion: v1.2
class: CommandLineTool
baseCommand: gepard
label: gepard
doc: "Genome Pair Rapid Dotter (Note: The provided help text contains only container
  runtime error messages and no usage information. No arguments could be extracted.)\n
  \nTool homepage: https://cube.univie.ac.at/gepard"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gepard:2.1.0--hdfd78af_1
stdout: gepard.out
