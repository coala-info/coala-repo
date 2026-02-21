cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanovar
label: nanoinsight_nanovar
doc: "NanoVar is a tool for detecting structural variants from long-read sequencing
  data. (Note: The provided text was an error log and did not contain help information;
  arguments could not be extracted.)\n\nTool homepage: https://github.com/AsmaaSamyMohamedMahmoud/nanoinsight"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoinsight:0.0.3--pyhdfd78af_0
stdout: nanoinsight_nanovar.out
