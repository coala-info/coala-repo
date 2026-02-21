cwlVersion: v1.2
class: CommandLineTool
baseCommand: stxtyper
label: ncbi-stxtyper_stxtyper
doc: "The provided text does not contain help information for the tool. It contains
  system error messages regarding container image conversion and disk space issues.\n
  \nTool homepage: https://github.com/ncbi/stxtyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-stxtyper:1.0.45--h9948957_0
stdout: ncbi-stxtyper_stxtyper.out
