cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-trust4
label: trust4_run-trust4
doc: "The provided text contains system error messages (out of disk space during container
  extraction) rather than the help text for the tool. No arguments could be extracted
  from the provided input.\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: trust4_run-trust4.out
