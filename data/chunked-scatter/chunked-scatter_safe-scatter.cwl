cwlVersion: v1.2
class: CommandLineTool
baseCommand: chunked-scatter
label: chunked-scatter_safe-scatter
doc: "A tool for chunked scattering, likely used in bioinformatics workflows (Note:
  The provided text is an error log and does not contain usage information).\n\nTool
  homepage: https://github.com/biowdl/chunked-scatter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chunked-scatter:1.0.0--py_0
stdout: chunked-scatter_safe-scatter.out
