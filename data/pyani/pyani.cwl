cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyani
label: pyani
doc: "The provided text is a container build log and does not contain help information
  or argument definitions for the pyani tool.\n\nTool homepage: https://github.com/widdowquinn/pyani"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
stdout: pyani.out
