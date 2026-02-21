cwlVersion: v1.2
class: CommandLineTool
baseCommand: setuptools_cython_pip
label: setuptools_cython_pip
doc: "The provided text is a system error log from an Apptainer/Singularity build
  process and does not contain CLI help documentation or argument definitions.\n\n
  Tool homepage: https://github.com/Technologicat/setup-template-cython"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/setuptools_cython:0.2.1--py27_1
stdout: setuptools_cython_pip.out
