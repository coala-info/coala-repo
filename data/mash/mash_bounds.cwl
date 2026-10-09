cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mash
  - bounds
label: mash_bounds
doc: "Mash distance and Screen distance calculations based on sketch size and distance
  thresholds.\n\nTool homepage: https://github.com/marbl/Mash"
inputs:
  - id: k
    type:
      - 'null'
      - int
    doc: k-mer size. (1-32)
    inputBinding:
      position: 101
      prefix: -k
  - id: p
    type:
      - 'null'
      - float
    doc: Mash distance estimates will be within the given error bounds with this probability. (0-1)
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mash:2.3--hb105d93_10
stdout: mash_bounds.out
