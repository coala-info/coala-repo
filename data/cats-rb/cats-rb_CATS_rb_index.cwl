cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CATS_rb_index
label: cats-rb_CATS_rb_index
doc: "Index tool for CATS-rb (Note: The provided help text contains system error messages
  regarding container extraction and does not list specific command-line arguments).\n
  \nTool homepage: https://github.com/bodulic/CATS-rb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cats-rb:1.0.3--hdfd78af_0
stdout: cats-rb_CATS_rb_index.out
