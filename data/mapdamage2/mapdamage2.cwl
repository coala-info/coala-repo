cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapdamage2
label: mapdamage2
doc: "The provided text is a system error log and does not contain help information
  or a description of the tool. mapDamage2 is typically used for tracking and modeling
  DNA damage patterns in ancient DNA sequences.\n\nTool homepage: https://github.com/ginolhac/mapDamage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapdamage2:2.2.3--py312h4711d71_0
stdout: mapdamage2.out
