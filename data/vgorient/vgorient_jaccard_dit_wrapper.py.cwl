cwlVersion: v1.2
class: CommandLineTool
baseCommand: vgorient_jaccard_dit_wrapper.py
label: vgorient_jaccard_dit_wrapper.py
doc: "A wrapper script for vgorient. (Note: The provided help text contains only container
  runtime error messages and does not list specific tool arguments.)\n\nTool homepage:
  https://github.com/whelixw/vgOrient"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0
stdout: vgorient_jaccard_dit_wrapper.py.out
