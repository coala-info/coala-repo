cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytriangle
label: pytriangle
doc: "A tool for triangle mesh generation (Note: The provided text contains container
  runtime logs rather than tool help text, so specific arguments could not be extracted).\n
  \nTool homepage: https://github.com/pletzer/pytriangle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytriangle:1.0.9--py312h0fa9677_10
stdout: pytriangle.out
