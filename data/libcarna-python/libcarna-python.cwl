cwlVersion: v1.2
class: CommandLineTool
baseCommand: libcarna-python
label: libcarna-python
doc: "Python bindings for the CARNA RNA alignment tool (Note: The provided text is
  a container execution error log and does not contain usage instructions or argument
  definitions).\n\nTool homepage: https://github.com/kostrykin/LibCarna-Python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libcarna-python:0.2.0--py310h184ae93_1
stdout: libcarna-python.out
