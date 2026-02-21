cwlVersion: v1.2
class: CommandLineTool
baseCommand: dicomscope
label: dicomscope
doc: "DICOM viewer and communication tool. (Note: The provided text contains container
  runtime error logs rather than the tool's help documentation.)\n\nTool homepage:
  https://github.com/csk16/dicomscope-app"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dicomscope:v3.6.0-20-deb_cv1
stdout: dicomscope.out
