cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haphpipe
  - assemble_02
label: haphpipe_haphpipe_assemble_02
doc: "The provided text contains system error messages related to a container runtime
  failure (no space left on device) and does not contain the actual help documentation
  for the tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_haphpipe_assemble_02.out
