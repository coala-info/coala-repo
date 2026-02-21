cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccphylo
label: ccphylo
doc: "A tool for phylogenetics (Note: The provided help text contains only container
  execution logs and error messages, no usage information was found).\n\nTool homepage:
  https://bitbucket.org/genomicepidemiology/ccphylo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
stdout: ccphylo.out
