cwlVersion: v1.2
class: CommandLineTool
baseCommand: hamronization
label: hamronization
doc: "A tool for harmonizing antimicrobial resistance (AMR) gene detection results
  (Note: The provided help text contains only system error messages and no usage information).\n
  \nTool homepage: https://github.com/pha4ge/hAMRonization"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
stdout: hamronization.out
