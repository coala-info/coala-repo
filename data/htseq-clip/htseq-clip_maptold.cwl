cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq-clip
label: htseq-clip_maptold
doc: "htseq-clip: error: argument subparser: invalid choice: 'maptold' (choose from
  'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix',
  'createMaxCountMatrix', 'trimAnnotation')\n\nTool homepage: https://github.com/EMBL-Hentze-group/htseq-clip"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
stdout: htseq-clip_maptold.out
