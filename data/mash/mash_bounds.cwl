cwlVersion: v1.2
class: CommandLineTool
baseCommand: mash_bounds
label: mash_bounds
doc: "Mash distance and Screen distance calculations based on sketch size and distance
  thresholds.\n\nTool homepage: https://github.com/marbl/Mash"
inputs:
  - id: k
    type:
      - 'null'
      - int
    doc: k-mer size
    inputBinding:
      position: 101
  - id: p
    type:
      - 'null'
      - float
    doc: Probability threshold
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mash:2.3--hb105d93_10
stdout: mash_bounds.out
