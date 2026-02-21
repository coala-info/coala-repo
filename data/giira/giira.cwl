cwlVersion: v1.2
class: CommandLineTool
baseCommand: giira
label: giira
doc: "GIIRA is a gene prediction tool that incorporates RNA-Seq data to improve the
  accuracy of gene identification.\n\nTool homepage: https://github.com/chcardonat/GIIRA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/giira:v0.0.20140625-2-deb_cv1
stdout: giira.out
