cwlVersion: v1.2
class: CommandLineTool
baseCommand: mintmap
label: mintmap
doc: "MINTmap (Molecular Indexing of tRNA fragments) is a tool for the discovery and
  profiling of tRNA-derived fragments. Note: The provided text is a system error message
  regarding container execution and does not contain usage instructions or argument
  definitions.\n\nTool homepage: https://github.com/TJU-CMC-Org/MINTmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mintmap:1.0--1
stdout: mintmap.out
