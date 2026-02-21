cwlVersion: v1.2
class: CommandLineTool
baseCommand: medcon
label: medcon_python
doc: "A tool for medical image conversion (Note: The provided text contains system
  error logs rather than help documentation, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/nadavlab/MedConceptsQA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/medcon:v0.16.1dfsg-1-deb_cv1
stdout: medcon_python.out
