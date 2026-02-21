cwlVersion: v1.2
class: CommandLineTool
baseCommand: zol
label: zol
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/Kalan-Lab/zol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
stdout: zol.out
