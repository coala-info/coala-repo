cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quantms-rescoring
  - rescoring
label: quantms-rescoring_rescoring
doc: "A tool for rescoring in the quantMS pipeline. (Note: The provided input text
  contains container runtime error logs rather than the tool's help documentation.)\n
  \nTool homepage: https://www.github.com/bigbio/quantms-rescoring"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantms-rescoring:0.0.10--pyhdfd78af_0
stdout: quantms-rescoring_rescoring.out
