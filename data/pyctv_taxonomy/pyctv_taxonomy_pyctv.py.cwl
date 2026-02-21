cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyctv_taxonomy_pyctv.py
label: pyctv_taxonomy_pyctv.py
doc: "A tool for taxonomy analysis (Note: The provided text contains container execution
  logs and error messages rather than help text; no arguments could be extracted from
  the input).\n\nTool homepage: https://github.com/linsalrob/pyctv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyctv_taxonomy:0.25--pyhdfd78af_0
stdout: pyctv_taxonomy_pyctv.py.out
