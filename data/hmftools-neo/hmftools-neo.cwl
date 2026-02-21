cwlVersion: v1.2
class: CommandLineTool
baseCommand: neo
label: hmftools-neo
doc: "The provided text does not contain help information or usage instructions. It
  is a system error message indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/neo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-neo:1.2.1--hdfd78af_0
stdout: hmftools-neo.out
