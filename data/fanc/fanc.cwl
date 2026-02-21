cwlVersion: v1.2
class: CommandLineTool
baseCommand: fanc
label: fanc
doc: "The provided text does not contain help information for the tool 'fanc'. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/vaquerizaslab/fanc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37hf01694f_0
stdout: fanc.out
