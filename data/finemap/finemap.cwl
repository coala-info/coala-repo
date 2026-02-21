cwlVersion: v1.2
class: CommandLineTool
baseCommand: finemap
label: finemap
doc: "FINEMAP is a program for identifying causal variants in genomic regions. (Note:
  The provided help text contains only container runtime error messages and no usage
  information.)\n\nTool homepage: http://www.christianbenner.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finemap:1.4.2--hb192632_1
stdout: finemap.out
