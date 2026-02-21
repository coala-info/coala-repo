cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe
label: haphpipe
doc: "HAphtype PHylogeny PIPEline (Note: The provided help text contains only container
  runtime error messages and no usage information.)\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe.out
