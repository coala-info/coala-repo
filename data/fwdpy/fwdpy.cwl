cwlVersion: v1.2
class: CommandLineTool
baseCommand: fwdpy
label: fwdpy
doc: "The provided text does not contain help information for fwdpy; it contains error
  logs from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/molpopgen/fwdpy11"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fwdpy:0.0.4pre1--py35_gsl1.16_0
stdout: fwdpy.out
