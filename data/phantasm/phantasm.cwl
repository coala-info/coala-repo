cwlVersion: v1.2
class: CommandLineTool
baseCommand: phantasm
label: phantasm
doc: "PHANTASM: PHylogenomic ANalysis of baSteriM (a tool for phylogenomic analysis)\n
  \nTool homepage: https://github.com/dr-joe-wirth/phantasm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phantasm:1.1.3--pyhdfd78af_0
stdout: phantasm.out
