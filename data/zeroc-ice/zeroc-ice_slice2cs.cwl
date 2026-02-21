cwlVersion: v1.2
class: CommandLineTool
baseCommand: slice2cs
label: zeroc-ice_slice2cs
doc: "Slice to C# compiler (ZeroC Ice)\n\nTool homepage: https://github.com/zeroc-ice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zeroc-ice:3.7.1--py35hd0a1c67_0
stdout: zeroc-ice_slice2cs.out
