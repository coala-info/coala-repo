cwlVersion: v1.2
class: CommandLineTool
baseCommand: octopus
label: octopus
doc: "A germline and somatic variant caller for next-generation sequencing data.\n
  \nTool homepage: https://github.com/luntergroup/octopus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/octopus:0.7.4--ha3c1580_2
stdout: octopus.out
