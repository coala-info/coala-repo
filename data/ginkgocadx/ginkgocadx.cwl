cwlVersion: v1.2
class: CommandLineTool
baseCommand: ginkgocadx
label: ginkgocadx
doc: "Ginkgo CADx is a multi-platform DICOM viewer and dicomizer. (Note: The provided
  text contains system error messages regarding a container runtime failure and does
  not include specific CLI help documentation.)\n\nTool homepage: https://github.com/gerddie/ginkgocadx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ginkgocadx:v3.8.8-1-deb_cv1
stdout: ginkgocadx.out
