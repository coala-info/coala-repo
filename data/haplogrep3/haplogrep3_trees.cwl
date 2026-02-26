cwlVersion: v1.2
class: CommandLineTool
baseCommand: haplogrep3_trees
label: haplogrep3_trees
doc: "Available trees:\n\nTool homepage: https://haplogrep.i-med.ac.at"
inputs:
  - id: tree
    type:
      - 'null'
      - type: array
        items: string
    doc: PhyloTree 17 - Forensic Update
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
stdout: haplogrep3_trees.out
