cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthanc-dicomweb
label: orthanc-dicomweb
doc: "Orthanc DICOMweb plugin/tool. (Note: The provided text contains system error
  logs rather than command-line help documentation, so no arguments could be extracted.)\n\
  \nTool homepage: https://github.com/ThalesMMS/Orthanc-PACS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/orthanc-dicomweb:v0.6dfsg-1-deb_cv1
stdout: orthanc-dicomweb.out
