cwlVersion: v1.2
class: CommandLineTool
baseCommand: heliano_cons
label: heliano_heliano_cons
doc: "Helitron identification and consensus sequence generation tool (Note: Provided
  help text contained only system error messages; no arguments could be extracted).\n
  \nTool homepage: https://github.com/Zhenlisme/heliano"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/heliano:1.3.1--hdfd78af_0
stdout: heliano_heliano_cons.out
