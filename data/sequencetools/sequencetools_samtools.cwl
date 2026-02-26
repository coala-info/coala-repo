cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: sequencetools_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://github.com/stschiff/sequenceTools"
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
    dockerPull: quay.io/biocontainers/sequencetools:1.6.0.0--hebebf5b_0
stdout: sequencetools_samtools.out
