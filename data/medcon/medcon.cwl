cwlVersion: v1.2
class: CommandLineTool
baseCommand: medcon
label: medcon
doc: "Medical Image Conversion tool (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://github.com/nadavlab/MedConceptsQA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/medcon:v0.16.1dfsg-1-deb_cv1
stdout: medcon.out
