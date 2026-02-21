cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyasp
label: pyasp
doc: "A Python library for Answer Set Programming. (Note: The provided text contains
  container build logs and error messages rather than CLI help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: http://pypi.python.org/pypi/pyasp/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyasp:1.4.3--py35_1
stdout: pyasp.out
