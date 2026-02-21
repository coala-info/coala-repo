cwlVersion: v1.2
class: CommandLineTool
baseCommand: plothic
label: plothic
doc: "The provided text does not contain help information or usage instructions for
  the tool 'plothic'. It contains error logs related to a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/Jwindler/PlotHiC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plothic:1.0.0--pyh5707d69_0
stdout: plothic.out
