cwlVersion: v1.2
class: CommandLineTool
baseCommand: lollipop
label: lollipop
doc: "A tool for visualizing genomic mutations (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/cbg-ethz/LolliPop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lollipop:0.5.3--pyhdfd78af_0
stdout: lollipop.out
