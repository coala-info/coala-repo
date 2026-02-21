cwlVersion: v1.2
class: CommandLineTool
baseCommand: esviritu
label: esviritu
doc: "A tool for identifying and characterizing viral sequences (Note: The provided
  help text contains only container runtime error messages and no usage information).\n
  \nTool homepage: https://github.com/cmmr/EsViritu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esviritu:1.1.6--pyhdfd78af_0
stdout: esviritu.out
