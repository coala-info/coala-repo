cwlVersion: v1.2
class: CommandLineTool
baseCommand: simscsntree_read_tree.py
label: simscsntree_read_tree.py
doc: "The provided text contains container runtime error logs and does not include
  help documentation or usage instructions for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/compbiofan/SimSCSnTree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simscsntree:0.0.9--pyh5e36f6f_0
stdout: simscsntree_read_tree.py.out
