cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirfix
label: mirfix
doc: "A tool for correcting miRNA sequences (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/Bierinformatik/MIRfix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirfix:2.1.1--hdfd78af_0
stdout: mirfix.out
