cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthanc
label: orthanc
doc: "Orthanc is a lightweight, RESTful DICOM server for healthcare and life sciences.
  (Note: The provided text appears to be a container build log rather than help text;
  no arguments could be extracted from the input).\n\nTool homepage: https://github.com/jodogne/OrthancDocker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/orthanc:v1.5.6dfsg-1-deb_cv1
stdout: orthanc.out
