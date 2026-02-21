cwlVersion: v1.2
class: CommandLineTool
baseCommand: clsify
label: clsify
doc: "A tool for taxonomic classification (Note: The provided text contains only container
  build error logs and no help documentation. No arguments could be extracted from
  the input.)\n\nTool homepage: https://github.com/holtgrewe/clsify"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clsify:0.1.1--py_0
stdout: clsify.out
