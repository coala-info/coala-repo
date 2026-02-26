cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq-clip
label: htseq-clip_createmaxcountmatrix
doc: "htseq-clip: error: argument subparser: invalid choice: 'createmaxcountmatrix'
  (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count',
  'createMatrix', 'createMaxCountMatrix', 'trimAnnotation')\n\nTool homepage: https://github.com/EMBL-Hentze-group/htseq-clip"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (choose from 'annotation', 'createSlidingWindows', 
      'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 
      'trimAnnotation')
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
stdout: htseq-clip_createmaxcountmatrix.out
