cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem
label: singlem
doc: "SingleM is a tool for finding and quantifying microbial lineages in metagenomic
  data.\n\nTool homepage: https://github.com/wwood/singlem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_1
stdout: singlem.out
