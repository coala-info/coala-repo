cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytest
label: pytest-xdist
doc: "A pytest plugin for distributed testing and loop-on-failing modes.\n\nTool homepage:
  https://github.com/pytest-dev/pytest-xdist"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytest-xdist:1.14--py36_0
stdout: pytest-xdist.out
