cwlVersion: v1.2
class: CommandLineTool
baseCommand: spotyping3
label: spotyping3
doc: "A tool for spoligotyping (Note: The provided text is a container engine error
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/matnguyen/SpoTyping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spotyping3:3.0--py_0
stdout: spotyping3.out
