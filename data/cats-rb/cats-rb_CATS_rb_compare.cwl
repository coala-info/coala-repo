cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CATS_rb_compare
label: cats-rb_CATS_rb_compare
doc: "A tool from the cats-rb package. (Note: The provided help text contains only
  system error messages regarding container extraction and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/bodulic/CATS-rb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cats-rb:1.0.3--hdfd78af_0
stdout: cats-rb_CATS_rb_compare.out
