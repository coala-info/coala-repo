cwlVersion: v1.2
class: CommandLineTool
baseCommand: longqc_minimap2-coverage
label: longqc_minimap2-coverage
doc: "LongQC minimap2-coverage tool (Note: The provided help text contains only system
  error logs and no usage information).\n\nTool homepage: https://github.com/yfukasawa/LongQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longqc:1.2.0c--hdfd78af_0
stdout: longqc_minimap2-coverage.out
