cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcgtree
label: bcgtree
doc: "A tool for bacterial phylogenomic tree construction based on core genes. (Note:
  The provided input text is an error log and does not contain usage information;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/molbiodiv/bcgtree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcgtree:1.2.1--pl5321hdfd78af_0
stdout: bcgtree.out
