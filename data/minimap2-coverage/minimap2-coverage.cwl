cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimap2-coverage
label: minimap2-coverage
doc: "A tool for calculating coverage from minimap2 alignments. Note: The provided
  help text contains a system error (no space left on device) and does not list specific
  arguments.\n\nTool homepage: https://github.com/yfukasawa/LongQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimap2-coverage:1.2.0c--h577a1d6_4
stdout: minimap2-coverage.out
