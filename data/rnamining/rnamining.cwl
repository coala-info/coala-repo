cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnamining
label: rnamining
doc: "RNAmining is a tool for RNA coding potential prediction. (Note: The provided
  text is a container build/execution error log and does not contain CLI help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/lfreitasl/RNAmining/tree/pypackage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnamining:1.0.4--pyhdfd78af_0
stdout: rnamining.out
