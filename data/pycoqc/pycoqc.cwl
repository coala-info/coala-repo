cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycoqc
label: pycoqc
doc: "The provided text does not contain help information or a description of the
  tool. It contains system logs and a fatal error related to fetching a container
  image.\n\nTool homepage: https://github.com/EnrightLab/pycoQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycoqc:2.5.2--py_0
stdout: pycoqc.out
