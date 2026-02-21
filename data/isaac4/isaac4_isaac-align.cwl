cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isaac-align
label: isaac4_isaac-align
doc: "Isaac Genome Alignment Software (Note: The provided text contains container
  runtime error messages rather than tool help text; no arguments could be extracted).\n
  \nTool homepage: https://github.com/Illumina/Isaac4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isaac4:04.18.11.09--h07bff40_0
stdout: isaac4_isaac-align.out
