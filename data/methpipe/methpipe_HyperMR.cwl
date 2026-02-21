cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hypermr
label: methpipe_HyperMR
doc: "The provided text is an error log indicating a failure to pull or convert the
  Methpipe container image due to lack of disk space. It does not contain the help
  text or usage information for the hypermr tool.\n\nTool homepage: https://github.com/smithlabcode/methpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
stdout: methpipe_HyperMR.out
