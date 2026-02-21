cwlVersion: v1.2
class: CommandLineTool
baseCommand: mptp
label: mptp
doc: "The provided text does not contain help information or usage instructions for
  the tool 'mptp'. It contains error messages related to a container runtime (Apptainer/Singularity)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/Pas-Kapli/mptp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mptp:v0.2.4-1-deb_cv1
stdout: mptp.out
