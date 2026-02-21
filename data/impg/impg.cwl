cwlVersion: v1.2
class: CommandLineTool
baseCommand: impg
label: impg
doc: "Implicit Pangenome Graph tool (Note: The provided text contains only container
  runtime error messages and no help documentation. No arguments could be extracted.)\n
  \nTool homepage: https://github.com/pangenome/impg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
stdout: impg.out
