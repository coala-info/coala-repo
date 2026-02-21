cwlVersion: v1.2
class: CommandLineTool
baseCommand: genview
label: genview
doc: "\nTool homepage: https://github.com/EbmeyerSt/GEnView.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genview:0.2--pyhdfd78af_0
stdout: genview.out
