cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-apo
label: meta-apo
doc: "The provided text does not contain a description of the tool as it consists
  of system log messages and a fatal error regarding disk space.\n\nTool homepage:
  https://github.com/qibebt-bioinfo/meta-apo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-apo:1.1--h9948957_7
stdout: meta-apo.out
