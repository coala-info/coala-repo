cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthanc-dev
label: orthanc-dev
doc: "Orthanc is a lightweight, RESTful DICOM server for healthcare and life sciences.\n\
  \nTool homepage: https://github.com/hieutnbk2011/Orthanc-Docker-DEV_RIS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/orthanc-dev:v1.5.6dfsg-1-deb_cv1
stdout: orthanc-dev.out
