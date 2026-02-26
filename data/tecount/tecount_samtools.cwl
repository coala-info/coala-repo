cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: tecount_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://github.com/bodegalab/tecount"
inputs:
  - id: command
    type: string
    doc: samtools command
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: command specific options
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tecount:1.0.1--pyhdfd78af_0
stdout: tecount_samtools.out
