cwlVersion: v1.2
class: CommandLineTool
baseCommand: tmhgf
label: tmhg_tmhgf
doc: "tMHG-Finder: Guide-Tree Based Homology Group Finder\n\nTool homepage: https://github.com/yongze-yin/tMHG-Finder/"
inputs:
  - id: mode
    type: string
    doc: tMHG-Finder mode
    inputBinding:
      position: 1
  - id: add
    type:
      - 'null'
      - boolean
    doc: Add genome to existing tMHG-Finder run
    inputBinding:
      position: 102
  - id: find
    type:
      - 'null'
      - boolean
    doc: Run tMHG-Finder on set of genomes
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmhg:1.0.3--pyhdfd78af_0
stdout: tmhg_tmhgf.out
