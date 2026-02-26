cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermitool
label: fermikit_trimadap-mt
doc: "A tool for adapter trimming.\n\nTool homepage: https://github.com/lh3/fermikit"
inputs:
  - id: adapters
    type:
      type: array
      items: File
    doc: Adapter sequences to trim.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_trimadap-mt.out
