cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - cnveval
label: rtg-tools_cnveval
doc: "Evaluate copy number variant calls. (Note: The provided text contains container
  runtime error messages rather than the tool's help documentation.)\n\nTool homepage:
  https://github.com/RealTimeGenomics/rtg-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_cnveval.out
