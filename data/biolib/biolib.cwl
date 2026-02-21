cwlVersion: v1.2
class: CommandLineTool
baseCommand: biolib
label: biolib
doc: "BioLib command line tool\n\nTool homepage: http://pypi.python.org/pypi/biolib/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biolib:0.1.9--py_0
stdout: biolib.out
