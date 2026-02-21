cwlVersion: v1.2
class: CommandLineTool
baseCommand: setuptools_scm
label: setuptools_scm
doc: "The provided text appears to be a container build log (Apptainer/Singularity)
  rather than CLI help text. No command-line arguments, options, or usage instructions
  were found in the input.\n\nTool homepage: https://github.com/pypa/setuptools-scm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/setuptools_cython:0.2.1--py27_1
stdout: setuptools_scm.out
