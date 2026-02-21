cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - accusnv
  - downstream
label: accusnv_accusnv_downstream
doc: "AccuSNV downstream analysis tool. (Note: The provided help text contains system
  error logs and does not list specific command-line arguments.)\n\nTool homepage:
  https://github.com/liaoherui/AccuSNV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/accusnv:1.0.0.5--pyhdfd78af_0
stdout: accusnv_accusnv_downstream.out
