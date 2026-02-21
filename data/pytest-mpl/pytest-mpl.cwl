cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytest
label: pytest-mpl
doc: "A pytest plugin to help with testing figures output from Matplotlib. Note: The
  provided text appears to be a container build error log rather than CLI help text,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/matplotlib/pytest-mpl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytest-mpl:0.5--py36_0
stdout: pytest-mpl.out
