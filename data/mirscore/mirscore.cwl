cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirscore
label: mirscore
doc: "A tool for scoring miRNA (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/Aez35/miRScore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirscore:0.3.4--hdfd78af_0
stdout: mirscore.out
