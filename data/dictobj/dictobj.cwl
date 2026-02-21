cwlVersion: v1.2
class: CommandLineTool
baseCommand: dictobj
label: dictobj
doc: "A tool for handling dictionary-like objects (Note: The provided text contains
  system error messages rather than help documentation).\n\nTool homepage: https://github.com/grimwm/py-dictobj"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dictobj:v0.4-1-deb-py2_cv1
stdout: dictobj.out
