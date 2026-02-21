cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmypy
label: mypy_dmypy
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/python/mypy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mypy:v0.670-2-deb-py3_cv1
stdout: mypy_dmypy.out
