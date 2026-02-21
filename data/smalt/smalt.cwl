cwlVersion: v1.2
class: CommandLineTool
baseCommand: smalt
label: smalt
doc: "The provided text does not contain help information for the tool 'smalt'. It
  contains error logs from a container runtime (Apptainer/Singularity) attempting
  to fetch the tool's image.\n\nTool homepage: https://github.com/roquie/smalte"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smalt:v0.7.6-8-deb_cv1
stdout: smalt.out
