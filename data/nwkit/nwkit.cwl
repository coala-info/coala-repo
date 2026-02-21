cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit
label: nwkit
doc: "Newick toolkit for processing phylogenetic trees. (Note: The provided help text
  contains only container runtime error logs and does not list usage or arguments.)\n
  \nTool homepage: https://github.com/kfuku52/nwkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nwkit:0.18.2--pyhdfd78af_1
stdout: nwkit.out
