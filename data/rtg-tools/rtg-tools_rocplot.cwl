cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - rocplot
label: rtg-tools_rocplot
doc: "The provided text does not contain help information for rtg-tools_rocplot; it
  contains container execution error logs.\n\nTool homepage: https://github.com/RealTimeGenomics/rtg-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rocplot.out
