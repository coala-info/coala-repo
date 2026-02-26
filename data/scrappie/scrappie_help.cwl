cwlVersion: v1.2
class: CommandLineTool
baseCommand: scrappie
label: scrappie_help
doc: "Scrappie is a technology demonstrator for the Oxford Nanopore Technologies Limited
  Research Algorithms group.\n\nTool homepage: https://github.com/nanoporetech/scrappie"
inputs:
  - id: command
    type: string
    doc: 'Scrappie command to execute. Available commands: events, help, licence,
      raw, version, squiggle, mappy, seqmappy, event_table.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
stdout: scrappie_help.out
