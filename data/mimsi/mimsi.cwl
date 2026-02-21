cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimsi
label: mimsi
doc: "The provided text is an error log from a container runtime and does not contain
  the help documentation for the tool 'mimsi'. As a result, no arguments could be
  extracted.\n\nTool homepage: https://github.com/mskcc/mimsi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
stdout: mimsi.out
