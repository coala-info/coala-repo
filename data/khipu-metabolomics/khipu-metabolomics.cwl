cwlVersion: v1.2
class: CommandLineTool
baseCommand: khipu
label: khipu-metabolomics
doc: "A tool for untargeted metabolomics data pre-processing and analysis. (Note:
  The provided input text was a system error message regarding container execution
  and did not contain command-line argument definitions.)\n\nTool homepage: https://github.com/shuzhao-li/khipu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khipu-metabolomics:2.0.4--pyhdfd78af_0
stdout: khipu-metabolomics.out
