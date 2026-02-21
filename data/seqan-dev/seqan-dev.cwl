cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqan-dev
label: seqan-dev
doc: "The provided text does not contain help information or usage instructions for
  seqan-dev. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract the container image due to insufficient
  disk space.\n\nTool homepage: http://www.seqan.de/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seqan-dev:v1.4.2dfsg-3-deb_cv1
stdout: seqan-dev.out
