cwlVersion: v1.2
class: CommandLineTool
baseCommand: elastix
label: elastix
doc: "The provided text does not contain help information for the elastix tool; it
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/SuperElastix/elastix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/elastix:v4.9.0-1-deb_cv1
stdout: elastix.out
