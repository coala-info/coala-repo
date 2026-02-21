cwlVersion: v1.2
class: CommandLineTool
baseCommand: qrisk2
label: qrisk2
doc: "The QRISK2 algorithm calculates the risk of developing cardiovascular disease
  (CVD) over the next ten years.\n\nTool homepage: https://github.com/BlackPearSw/qrisk2-2014"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/qrisk2:v0.1.20150729-4-deb_cv1
stdout: qrisk2.out
