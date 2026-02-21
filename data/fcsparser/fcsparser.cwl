cwlVersion: v1.2
class: CommandLineTool
baseCommand: fcsparser
label: fcsparser
doc: "A tool for parsing Flow Cytometry Standard (FCS) files. (Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific CLI arguments.)\n\nTool homepage: https://github.com/eyurtsev/fcsparser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fcsparser:0.2.8--pyhdfd78af_0
stdout: fcsparser.out
