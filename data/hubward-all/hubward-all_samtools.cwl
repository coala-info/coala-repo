cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: hubward-all_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: command
    type: string
    doc: The samtools subcommand to execute (e.g., view, sort, index, etc.)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options and arguments specific to the chosen subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hubward-all:0.2.1--1
stdout: hubward-all_samtools.out
