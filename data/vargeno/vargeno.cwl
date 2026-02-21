cwlVersion: v1.2
class: CommandLineTool
baseCommand: vargeno
label: vargeno
doc: "A tool for SNP and indel calling from whole genome sequencing data (Note: Help
  text provided was a container pull error log, so arguments could not be parsed).\n
  \nTool homepage: https://github.com/medvedevgroup/vargeno"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vargeno:1.0.3--h9f5acd7_3
stdout: vargeno.out
