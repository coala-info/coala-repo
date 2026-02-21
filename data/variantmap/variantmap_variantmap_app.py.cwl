cwlVersion: v1.2
class: CommandLineTool
baseCommand: variantmap_variantmap_app.py
label: variantmap_variantmap_app.py
doc: "A tool for variant mapping (Note: The provided text contains container build
  logs and error messages rather than the tool's help documentation).\n\nTool homepage:
  https://github.com/cytham/variantmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variantmap:1.0.2--py_0
stdout: variantmap_variantmap_app.py.out
