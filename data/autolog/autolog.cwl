cwlVersion: v1.2
class: CommandLineTool
baseCommand: autolog
label: autolog
doc: "The provided text contains error logs related to a container runtime failure
  and does not include the help text or usage information for the 'autolog' tool.
  As a result, no arguments could be extracted.\n\nTool homepage: http://noble.gs.washington.edu/~mmh1/software/autolog/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autolog:0.2--py_0
stdout: autolog.out
