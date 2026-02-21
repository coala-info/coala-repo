cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - massiveqc
  - IsoDetect
label: massiveqc_IsoDetect
doc: "MassiveQC IsoDetect (Note: The provided help text contains only container runtime
  error messages and does not list specific command-line arguments).\n\nTool homepage:
  https://github.com/shimw6828/MassiveQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
stdout: massiveqc_IsoDetect.out
