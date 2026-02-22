cwlVersion: v1.2
class: CommandLineTool
baseCommand: belvu
label: belvu
doc: "The provided text does not contain help information for the tool 'belvu'. It
  contains system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull an image due to lack of disk space.\n\nTool homepage: https://github.com/nathanhaigh/docker-seqtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/belvu:v4.44.1dfsg-3-deb_cv1
stdout: belvu.out
