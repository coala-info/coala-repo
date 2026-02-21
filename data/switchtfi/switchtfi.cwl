cwlVersion: v1.2
class: CommandLineTool
baseCommand: switchtfi
label: switchtfi
doc: "A tool for switching transcription factor isoforms (SwitchTFI).\n\nTool homepage:
  https://github.com/bionetslab/SwitchTFI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/switchtfi:0.1.0--pyhdfd78af_0
stdout: switchtfi.out
