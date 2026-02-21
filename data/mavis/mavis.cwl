cwlVersion: v1.2
class: CommandLineTool
baseCommand: mavis
label: mavis
doc: "MAVIS: Merging, Annotation, Validation, and Illustration of Structural variants\n
  \nTool homepage: https://github.com/bcgsc/mavis.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
stdout: mavis.out
