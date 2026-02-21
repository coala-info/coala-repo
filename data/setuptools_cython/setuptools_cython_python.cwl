cwlVersion: v1.2
class: CommandLineTool
baseCommand: setuptools_cython
label: setuptools_cython_python
doc: "The provided text is a log of a failed container build process and does not
  contain help documentation or usage instructions for the tool. Consequently, no
  arguments could be extracted.\n\nTool homepage: https://github.com/Technologicat/setup-template-cython"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/setuptools_cython:0.2.1--py27_1
stdout: setuptools_cython_python.out
