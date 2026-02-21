cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-dictobj
label: python3-dictobj
doc: A Python module that provides a dictionary-like object whose keys can be accessed
  as attributes.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-dictobj:v0.4-1-deb_cv1
stdout: python3-dictobj.out
