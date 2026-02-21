cwlVersion: v1.2
class: CommandLineTool
baseCommand: metavelvet-sl
label: metavelvet-sl
doc: 'MetaVelvet-SL is a tool for metagenomic de novo assembly. (Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metavelvet-sl:1.0--1
stdout: metavelvet-sl.out
