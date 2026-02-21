cwlVersion: v1.2
class: CommandLineTool
baseCommand: py_nucflag
label: py_nucflag
doc: "Note: The provided text is a container build error log and does not contain
  help information or argument definitions for the tool.\n\nTool homepage: https://github.com/logsdon-lab/rs-nucflag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-sphinxcontrib.autoprogram:v0.1.2-1-deb_cv1
stdout: py_nucflag.out
