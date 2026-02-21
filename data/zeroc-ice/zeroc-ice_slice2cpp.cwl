cwlVersion: v1.2
class: CommandLineTool
baseCommand: slice2cpp
label: zeroc-ice_slice2cpp
doc: "The Slice-to-C++ compiler (Note: The provided help text contains container build
  logs and error messages rather than tool usage information).\n\nTool homepage: https://github.com/zeroc-ice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zeroc-ice:3.7.1--py35hd0a1c67_0
stdout: zeroc-ice_slice2cpp.out
