cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthanc-imagej
label: orthanc-imagej
doc: "Orthanc-ImageJ tool (Note: The provided text is a system error log and does
  not contain help documentation or argument definitions).\n\nTool homepage: https://github.com/lequynhnhu/orthanc-imagej"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/orthanc-imagej:v1.1dfsg-1-deb_cv1
stdout: orthanc-imagej.out
