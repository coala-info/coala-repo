cwlVersion: v1.2
class: CommandLineTool
baseCommand: ndex-python
label: ndex-python
doc: "The provided text is an error log regarding a container build failure and does
  not contain help documentation or argument definitions.\n\nTool homepage: https://github.com/ndexbio/ndex-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ndex-python:3.0.11.23--py27_0
stdout: ndex-python.out
