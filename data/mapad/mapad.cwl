cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapad
label: mapad
doc: "A tool for mapping ancient DNA (Note: The provided help text contains only system
  error messages regarding container execution and does not list usage or arguments).\n
  \nTool homepage: https://github.com/mpieva/mapAD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapad:0.45.0--ha96b9cd_1
stdout: mapad.out
