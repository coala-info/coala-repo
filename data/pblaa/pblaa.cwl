cwlVersion: v1.2
class: CommandLineTool
baseCommand: pblaa
label: pblaa
doc: "The provided text contains error logs indicating that the executable 'pblaa'
  was not found in the environment; no help text or usage information was available
  to parse.\n\nTool homepage: https://github.com/PacificBiosciences/pblaa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pblaa:2.4.2--0
stdout: pblaa.out
