cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyvcf3
label: pyvcf3
doc: "The provided text is a container engine error log and does not contain help
  information or usage instructions for the tool.\n\nTool homepage: https://github.com/dridk/PyVCF3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyvcf3:1.0.4--py311haab0aaa_0
stdout: pyvcf3.out
