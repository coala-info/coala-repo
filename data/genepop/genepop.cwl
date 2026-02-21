cwlVersion: v1.2
class: CommandLineTool
baseCommand: genepop
label: genepop
doc: "Genepop is a population genetics software package. (Note: The provided help
  text contains only system error messages and no usage information.)\n\nTool homepage:
  https://f-rousset.r-universe.dev/genepop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genepop:4.8.4--h9948957_0
stdout: genepop.out
