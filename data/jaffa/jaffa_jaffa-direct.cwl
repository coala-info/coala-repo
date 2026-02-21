cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaffa-direct
label: jaffa_jaffa-direct
doc: "JAFFA is a pipeline for identifying fusion genes from RNA-seq data. (Note: The
  provided help text contains only system error messages regarding container image
  creation and does not list specific command-line arguments).\n\nTool homepage: https://github.com/Oshlack/JAFFA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jaffa:2.3--hdfd78af_0
stdout: jaffa_jaffa-direct.out
