cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgat-core
label: cgat-core
doc: "The provided text is a container execution log indicating a failure to build
  or pull the image due to insufficient disk space. It does not contain the tool's
  help text or argument definitions.\n\nTool homepage: https://github.com/cgat-developers/cgat-core"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgat-core:0.5.14--py_0
stdout: cgat-core.out
