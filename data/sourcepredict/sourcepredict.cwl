cwlVersion: v1.2
class: CommandLineTool
baseCommand: sourcepredict
label: sourcepredict
doc: "SourcePredict is a tool for predicting the source of metagenomic samples. Note:
  The provided text contains error logs from a container build process rather than
  the tool's help documentation, so specific arguments could not be extracted from
  the input.\n\nTool homepage: https://github.com/maxibor/sourcepredict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourcepredict:0.5.1--pyhdfd78af_0
stdout: sourcepredict.out
