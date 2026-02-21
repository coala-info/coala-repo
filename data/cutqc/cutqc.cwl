cwlVersion: v1.2
class: CommandLineTool
baseCommand: cutqc
label: cutqc
doc: "A tool for quality control of sequencing data. (Note: The provided help text
  contains system error messages regarding a container build failure and does not
  list specific command-line arguments.)\n\nTool homepage: https://github.com/obenno/cutqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutqc:0.07--hdfd78af_0
stdout: cutqc.out
