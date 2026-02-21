cwlVersion: v1.2
class: CommandLineTool
baseCommand: quantms-rescoring
label: quantms-rescoring
doc: "A tool for rescoring in the quantms pipeline. Note: The provided help text contained
  only system error messages and no usage information.\n\nTool homepage: https://www.github.com/bigbio/quantms-rescoring"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantms-rescoring:0.0.10--pyhdfd78af_0
stdout: quantms-rescoring.out
