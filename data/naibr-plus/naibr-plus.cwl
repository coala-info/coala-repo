cwlVersion: v1.2
class: CommandLineTool
baseCommand: naibr-plus
label: naibr-plus
doc: "NAIBR+ (Novel Allelic Imbalance Realignment Plus). Note: The provided text contains
  system error messages regarding container image conversion and disk space, rather
  than tool usage instructions.\n\nTool homepage: https://github.com/pontushojer/NAIBR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/naibr-plus:0.5.3--pyhdfd78af_0
stdout: naibr-plus.out
