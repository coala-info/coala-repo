cwlVersion: v1.2
class: CommandLineTool
baseCommand: mygene
label: mygene
doc: "MyGene.info Python client/CLI tool (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/suLab/mygene.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mygene:3.2.2--pyh5e36f6f_0
stdout: mygene.out
