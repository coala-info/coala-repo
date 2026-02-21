cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyiron
label: pyiron
doc: "The provided text appears to be a container build log rather than CLI help text.
  No arguments or usage information could be extracted from the input.\n\nTool homepage:
  https://github.com/pyiron/pyiron"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyiron:0.2.2
stdout: pyiron.out
