cwlVersion: v1.2
class: CommandLineTool
baseCommand: squidpy
label: squidpy
doc: "Squidpy is a tool for the analysis and visualization of spatial molecular data.
  (Note: The provided text is a container build error log and does not contain CLI
  help information or argument definitions).\n\nTool homepage: https://github.com/scverse/squidpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squidpy:1.5.0
stdout: squidpy.out
