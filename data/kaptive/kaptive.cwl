cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaptive
label: kaptive
doc: "Kaptive: a tool for the automated typing of bacterial surface polysaccharide
  loci (K and O antigen loci). Note: The provided help text contains only system error
  messages regarding container execution and does not list command-line arguments.\n
  \nTool homepage: https://kaptive.readthedocs.io/en/latest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaptive:3.1.0--pyhdfd78af_0
stdout: kaptive.out
