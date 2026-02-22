cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthanc-webviewer
label: orthanc-webviewer
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container build process indicating a 'no space left on device'
  failure.\n\nTool homepage: https://github.com/orthanc-team/osimis-webviewer-deprecated"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/orthanc-webviewer:v2.5-1-deb_cv1
stdout: orthanc-webviewer.out
