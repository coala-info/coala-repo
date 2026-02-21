cwlVersion: v1.2
class: CommandLineTool
baseCommand: divvier
label: divvier
doc: "A tool for filtering phylogenomic data. (Note: The provided text contains container
  runtime error messages and does not include the actual help documentation or argument
  definitions for the tool.)\n\nTool homepage: https://github.com/simonwhelan/Divvier"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/divvier:1.01--h5ca1c30_5
stdout: divvier.out
