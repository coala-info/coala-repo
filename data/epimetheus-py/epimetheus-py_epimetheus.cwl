cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - epimetheus
label: epimetheus-py_epimetheus
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding disk space during
  a container build process.\n\nTool homepage: https://github.com/SebastianDall/epimetheus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epimetheus-py:0.7.7--py39hfa26904_0
stdout: epimetheus-py_epimetheus.out
