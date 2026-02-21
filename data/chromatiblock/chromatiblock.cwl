cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromatiblock
label: chromatiblock
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/extraction process
  due to insufficient disk space.\n\nTool homepage: http://github.com/mjsull/chromatiblock/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromatiblock:1.0.0--py_0
stdout: chromatiblock.out
