cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: repenrich_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://github.com/nskvir/RepEnrich"
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
    dockerPull: quay.io/biocontainers/repenrich:1.2--py27_1
stdout: repenrich_samtools.out
