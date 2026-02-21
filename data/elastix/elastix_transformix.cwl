cwlVersion: v1.2
class: CommandLineTool
baseCommand: transformix
label: elastix_transformix
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull an image due to insufficient disk space.\n\nTool homepage: https://github.com/SuperElastix/elastix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/elastix:v4.9.0-1-deb_cv1
stdout: elastix_transformix.out
