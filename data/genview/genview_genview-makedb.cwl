cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genview-makedb
label: genview_genview-makedb
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image conversion and disk
  space.\n\nTool homepage: https://github.com/EbmeyerSt/GEnView.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genview:0.2--pyhdfd78af_0
stdout: genview_genview-makedb.out
