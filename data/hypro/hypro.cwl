cwlVersion: v1.2
class: CommandLineTool
baseCommand: hypro
label: hypro
doc: "The provided text does not contain help information for the tool 'hypro'. It
  contains error messages related to a container runtime (Apptainer/Singularity) failing
  to pull a Docker image due to insufficient disk space.\n\nTool homepage: https://github.com/hoelzer-lab/hypro.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hypro:0.1--py_0
stdout: hypro.out
