cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkqc
label: checkqc
doc: "A tool for checking the quality of sequencing data (Note: The provided help
  text contains only system error logs and no usage information).\n\nTool homepage:
  https://www.github.com/Molmed/checkQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkqc:4.0.7--pyhdfd78af_0
stdout: checkqc.out
