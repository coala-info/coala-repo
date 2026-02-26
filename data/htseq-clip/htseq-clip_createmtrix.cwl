cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq-clip
label: htseq-clip_createmtrix
doc: "htseq-clip: error: argument subparser: invalid choice: 'createmtrix' (choose
  from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix',
  'createMaxCountMatrix', 'trimAnnotation')\n\nTool homepage: https://github.com/EMBL-Hentze-group/htseq-clip"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
stdout: htseq-clip_createmtrix.out
