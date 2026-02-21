cwlVersion: v1.2
class: CommandLineTool
baseCommand: naibr
label: naibr-plus_naibr
doc: "NAIBR (Novel Allelic Imbalance Realignment) is a tool for identifying structural
  variants (SVs) from linked-read sequencing data.\n\nTool homepage: https://github.com/pontushojer/NAIBR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/naibr-plus:0.5.3--pyhdfd78af_0
stdout: naibr-plus_naibr.out
