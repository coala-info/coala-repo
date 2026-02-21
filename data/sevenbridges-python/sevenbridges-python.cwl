cwlVersion: v1.2
class: CommandLineTool
baseCommand: sevenbridges-python
label: sevenbridges-python
doc: "The provided text does not contain help information or usage instructions. It
  is a system error log indicating a failure to build or extract a Singularity/Apptainer
  container image due to insufficient disk space ('no space left on device').\n\n
  Tool homepage: https://github.com/sbg/sevenbridges-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sevenbridges-python:2.11.2--pyhdfd78af_0
stdout: sevenbridges-python.out
