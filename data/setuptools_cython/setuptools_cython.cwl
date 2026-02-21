cwlVersion: v1.2
class: CommandLineTool
baseCommand: setuptools_cython
label: setuptools_cython
doc: "The provided text does not contain help documentation or usage instructions
  for setuptools_cython; it is a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/Technologicat/setup-template-cython"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/setuptools_cython:0.2.1--py27_1
stdout: setuptools_cython.out
