cwlVersion: v1.2
class: CommandLineTool
baseCommand: regtools junctions
label: regtools_junctions
doc: "Identify exon-exon junctions from alignments or annotate junctions.\n\nTool
  homepage: https://github.com/griffithlab/regtools/"
inputs:
  - id: command
    type: string
    doc: "Command to execute: 'extract' or 'annotate'"
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the chosen command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
stdout: regtools_junctions.out
