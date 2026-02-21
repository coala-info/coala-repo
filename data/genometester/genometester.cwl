cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometester
label: genometester
doc: "A suite of tools for genomic analysis. (Note: The provided help text contains
  only system error messages and does not list specific command-line arguments or
  descriptions.)\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/genometester:v4.0git20180508.a9c14a6dfsg-1-deb_cv1
stdout: genometester.out
