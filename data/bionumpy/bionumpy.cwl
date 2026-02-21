cwlVersion: v1.2
class: CommandLineTool
baseCommand: bionumpy
label: bionumpy
doc: "A Python library for biological sequence and genomic data analysis. (Note: The
  provided help text contains a Python ImportError and does not list available arguments.)\n
  \nTool homepage: https://github.com/bionumpy/bionumpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bionumpy:1.0.14--pyh05cac1d_0
stdout: bionumpy.out
