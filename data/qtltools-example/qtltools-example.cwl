cwlVersion: v1.2
class: CommandLineTool
baseCommand: qtltools-example
label: qtltools-example
doc: The provided text does not contain help information or usage instructions for
  the tool; it contains error logs from a container runtime (Apptainer/Singularity)
  failing to fetch the image.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/qtltools-example:v1.1dfsg-3-deb_cv1
stdout: qtltools-example.out
