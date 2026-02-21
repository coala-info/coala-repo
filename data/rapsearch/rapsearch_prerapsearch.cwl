cwlVersion: v1.2
class: CommandLineTool
baseCommand: prerapsearch
label: rapsearch_prerapsearch
doc: "The provided text does not contain help information for the tool; it contains
  container environment logs and a fatal error message. No arguments could be extracted.\n
  \nTool homepage: https://github.com/zhaoyanswill/RAPSearch2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapsearch:2.24--1
stdout: rapsearch_prerapsearch.out
