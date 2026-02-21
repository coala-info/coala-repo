cwlVersion: v1.2
class: CommandLineTool
baseCommand: ecopcr
label: ecopcr
doc: "The provided text does not contain help information for ecopcr; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/invertdna/PrimerDesignPipeline"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ecopcr:v1.0.1dfsg-1-deb_cv1
stdout: ecopcr.out
