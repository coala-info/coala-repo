cwlVersion: v1.2
class: CommandLineTool
baseCommand: rtg
label: rtg-tools
doc: "RTG Tools is a set of utilities for analyzing genomic data, including variant
  calling, pedigree analysis, and sequence processing.\n\nTool homepage: https://github.com/RealTimeGenomics/rtg-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools.out
