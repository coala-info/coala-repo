cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthanc-wsi
label: orthanc-wsi
doc: "Whole-slide imaging support for Orthanc (Note: The provided text contains system
  error messages regarding disk space and container image retrieval rather than command-line
  help documentation).\n\nTool homepage: https://github.com/hinh1108/orthanc-wsi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/orthanc-wsi:v0.6-2-deb_cv1
stdout: orthanc-wsi.out
