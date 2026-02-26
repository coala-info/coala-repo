cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_rss
label: bart_rss
doc: "Calculates root of sum of squares along selected dimensions.\n\nTool homepage:
  https://github.com/tomdstanton/bart"
inputs:
  - id: bitmask
    type: string
    doc: bitmask
    inputBinding:
      position: 1
  - id: input
    type: string
    doc: input
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_rss.out
