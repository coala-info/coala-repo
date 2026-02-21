cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbpipe
label: sbpipe
doc: "Systems Biology Pipeline (Note: The provided text is a container build error
  log and does not contain usage instructions or argument definitions.)\n\nTool homepage:
  http://sbpipe.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbpipe:4.21.0--py_0
stdout: sbpipe.out
