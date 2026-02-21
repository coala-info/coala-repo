cwlVersion: v1.2
class: CommandLineTool
baseCommand: haplotaglr
label: haplotaglr
doc: "A tool for haplotagging long reads (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/Boyle-Lab/HaplotagLR.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotaglr:1.1.13--pyhdfd78af_0
stdout: haplotaglr.out
