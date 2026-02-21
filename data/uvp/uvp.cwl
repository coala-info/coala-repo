cwlVersion: v1.2
class: CommandLineTool
baseCommand: uvp
label: uvp
doc: "The provided text contains container build logs rather than tool help text;
  therefore, no arguments or descriptions could be extracted.\n\nTool homepage: https://github.com/CPTR-ReSeqTB/UVP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uvp:2.7.0--py_0
stdout: uvp.out
