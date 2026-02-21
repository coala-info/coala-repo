cwlVersion: v1.2
class: CommandLineTool
baseCommand: aeskulap
label: aeskulap
doc: "Aeskulap is a medical image viewer (DICOM viewer).\n\nTool homepage: https://github.com/pipelka/aeskulap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/aeskulap:v0.2.2-beta2git20180219.8787e95-2-deb_cv1
stdout: aeskulap.out
