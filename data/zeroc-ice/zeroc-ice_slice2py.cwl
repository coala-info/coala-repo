cwlVersion: v1.2
class: CommandLineTool
baseCommand: slice2py
label: zeroc-ice_slice2py
doc: "Slice to Python compiler (Note: The provided text appears to be a container
  engine error log rather than the tool's help text. No arguments could be extracted
  from the input.)\n\nTool homepage: https://github.com/zeroc-ice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zeroc-ice:3.7.1--py35hd0a1c67_0
stdout: zeroc-ice_slice2py.out
