cwlVersion: v1.2
class: CommandLineTool
baseCommand: genoflu
label: genoflu
doc: "Genotyping of Influenza A viruses (Note: The provided text contains system error
  messages regarding container image building and does not include usage instructions
  or argument definitions).\n\nTool homepage: https://github.com/USDA-VS/GenoFLU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genoflu:1.06--hdfd78af_0
stdout: genoflu.out
