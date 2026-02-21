cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsutils
label: ngsutils
doc: "The provided text does not contain help information or usage instructions. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/ngsutils/ngsutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsutils:0.5.9--py27_0
stdout: ngsutils.out
