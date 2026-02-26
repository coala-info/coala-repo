cwlVersion: v1.2
class: CommandLineTool
baseCommand: pattern
label: bart_pattern
doc: "Compute sampling pattern from kspace\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: kspace
    type: string
    doc: kspace
    inputBinding:
      position: 1
  - id: pattern
    type: string
    doc: pattern
    inputBinding:
      position: 2
  - id: squash_dimensions
    type:
      - 'null'
      - string
    doc: Squash dimensions selected by bitmask
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_pattern.out
