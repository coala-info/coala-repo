cwlVersion: v1.2
class: CommandLineTool
baseCommand: edtsurf
label: edtsurf
doc: "EDTSurf is a software for generating triangulated surfaces of macromolecules.\n
  \nTool homepage: https://github.com/UnixJunkie/EDTSurf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/edtsurf:v0.2009-6-deb_cv1
stdout: edtsurf.out
