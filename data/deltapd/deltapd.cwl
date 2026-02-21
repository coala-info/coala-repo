cwlVersion: v1.2
class: CommandLineTool
baseCommand: deltapd
label: deltapd
doc: "A tool for analyzing or processing data (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/Ecogenomics/DeltaPD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deltapd:0.1.5--py39h918f1d6_7
stdout: deltapd.out
