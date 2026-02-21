cwlVersion: v1.2
class: CommandLineTool
baseCommand: cromwell
label: cromwell
doc: "Cromwell is a Workflow Management System. (Note: The provided text appears to
  be a system error log rather than help text, so no arguments could be extracted.)\n
  \nTool homepage: https://github.com/broadinstitute/cromwell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromwell:0.40--1
stdout: cromwell.out
