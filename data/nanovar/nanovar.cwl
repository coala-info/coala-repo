cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanovar
label: nanovar
doc: "NanoVar is a tool for structural variant discovery using long-read sequencing.
  (Note: The provided text is a container execution error log and does not contain
  help information or argument definitions.)\n\nTool homepage: https://github.com/cytham/nanovar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanovar:1.8.3--py311haab0aaa_0
stdout: nanovar.out
