cwlVersion: v1.2
class: CommandLineTool
baseCommand: cramino
label: nanopack_cramino
doc: "The provided text is a system error log (out of disk space) and does not contain
  help documentation or argument definitions for the tool.\n\nTool homepage: https://github.com/wdecoster/nanopack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopack:1.1.1--hdfd78af_0
stdout: nanopack_cramino.out
