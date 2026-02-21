cwlVersion: v1.2
class: CommandLineTool
baseCommand: omero
label: omero-py
doc: "Python client and CLI for OMERO (Note: The provided text contained only container
  runtime error logs and no help documentation).\n\nTool homepage: https://www.openmicroscopy.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/omero-py:5.17.0
stdout: omero-py.out
