cwlVersion: v1.2
class: CommandLineTool
baseCommand: curare
label: curare
doc: "The provided text is an error log from a container build process and does not
  contain help documentation or argument definitions for the 'curare' tool.\n\nTool
  homepage: https://github.com/pblumenkamp/Curare"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curare:0.6.0--pyhdfd78af_0
stdout: curare.out
