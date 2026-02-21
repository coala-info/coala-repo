cwlVersion: v1.2
class: CommandLineTool
baseCommand: slice2js
label: zeroc-ice_slice2js
doc: "Slice-to-JavaScript compiler (Note: The provided help text contains only container
  runtime error logs and no usage information).\n\nTool homepage: https://github.com/zeroc-ice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zeroc-ice:3.7.1--py35hd0a1c67_0
stdout: zeroc-ice_slice2js.out
