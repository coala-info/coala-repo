cwlVersion: v1.2
class: CommandLineTool
baseCommand: mipe
label: mipe
doc: "The provided text does not contain help information for the tool 'mipe'. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/mipengine/www.mipengine.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mipe:v1.1-7-deb_cv1
stdout: mipe.out
