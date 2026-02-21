cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq-to-first-iso
label: seq-to-first-iso
doc: "The provided text is a container engine error log and does not contain help
  information for the tool.\n\nTool homepage: https://github.com/pierrepo/seq-to-first-iso"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-to-first-iso:1.1.0--py_0
stdout: seq-to-first-iso.out
