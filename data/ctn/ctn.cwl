cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctn
label: ctn
doc: "The Central Test Node (CTN) software provides an implementation of the DICOM
  standard for medical image communication.\n\nTool homepage: https://github.com/casatwy/CTNetworking"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ctn:v3.2.0dfsg-5-deb_cv1
stdout: ctn.out
