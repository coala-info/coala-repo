cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch
label: msstitch
doc: "msstitch: a proteomics tool for MS proteomics data processing.\n\nTool homepage:
  https://github.com/lehtiolab/msstitch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.17--pyhdfd78af_0
stdout: msstitch.out
