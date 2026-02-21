cwlVersion: v1.2
class: CommandLineTool
baseCommand: kb
label: kb-python
doc: "The provided text does not contain help information for kb-python; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/pachterlab/kb_python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
stdout: kb-python.out
