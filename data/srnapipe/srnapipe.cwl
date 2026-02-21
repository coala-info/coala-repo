cwlVersion: v1.2
class: CommandLineTool
baseCommand: srnapipe
label: srnapipe
doc: "srnapipe is a pipeline for small RNA sequencing data analysis. (Note: The provided
  text is a container build error log and does not contain CLI help information; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/GReD-Clermont/sRNAPipe-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srnapipe:1.2.1--pl5321r44hdfd78af_0
stdout: srnapipe.out
