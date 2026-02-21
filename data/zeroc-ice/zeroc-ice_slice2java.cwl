cwlVersion: v1.2
class: CommandLineTool
baseCommand: slice2java
label: zeroc-ice_slice2java
doc: "Slice to Java compiler. (Note: The provided text contains container engine error
  logs rather than the tool's help documentation.)\n\nTool homepage: https://github.com/zeroc-ice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zeroc-ice:3.7.1--py35hd0a1c67_0
stdout: zeroc-ice_slice2java.out
