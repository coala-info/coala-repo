cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator_build_projection.py
label: domainator_build_projection.py
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container due to lack of disk space.\n\nTool homepage: https://github.com/nebiolabs/domainator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.0--pyhdfd78af_0
stdout: domainator_build_projection.py.out
