cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoinsight
label: nanoinsight
doc: "A tool for analyzing nanopore sequencing data (Note: The provided text is a
  system error log and does not contain usage instructions or argument descriptions).\n
  \nTool homepage: https://github.com/AsmaaSamyMohamedMahmoud/nanoinsight"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoinsight:0.0.3--pyhdfd78af_0
stdout: nanoinsight.out
