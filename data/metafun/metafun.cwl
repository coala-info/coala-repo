cwlVersion: v1.2
class: CommandLineTool
baseCommand: metafun
label: metafun
doc: "A tool for metagenomic functional analysis (Note: The provided text contains
  only system error logs and no help information).\n\nTool homepage: https://github.com/aababc1/metaFun"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafun:1.0.0--hdfd78af_0
stdout: metafun.out
