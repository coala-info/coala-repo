cwlVersion: v1.2
class: CommandLineTool
baseCommand: phykit
label: phykit
doc: "A toolkit for phylogenetic analysis (Note: The provided text appears to be a
  container runtime error log rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/jlsteenwyk/phykit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.2--pyhdfd78af_0
stdout: phykit.out
