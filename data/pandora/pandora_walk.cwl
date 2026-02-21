cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - /usr/local/bin/pandora
  - walk
label: pandora_walk
doc: "Outputs a path through the nodes in a PRG corresponding to the either an input
  sequence (if it exists) or the top/bottom path\n\nTool homepage: https://github.com/rmcolq/pandora"
inputs:
  - id: prg
    type: File
    doc: A PRG file (in fasta format)
    inputBinding:
      position: 1
  - id: bottom
    type:
      - 'null'
      - boolean
    doc: Output the bottom path through each local PRG
    inputBinding:
      position: 102
      prefix: --bottom
  - id: input
    type:
      - 'null'
      - File
    doc: Fast{a,q} of sequences to output paths through the PRG for
    inputBinding:
      position: 102
      prefix: --input
  - id: top
    type:
      - 'null'
      - boolean
    doc: Output the top path through each local PRG
    inputBinding:
      position: 102
      prefix: --top
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
stdout: pandora_walk.out
