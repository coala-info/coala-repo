cwlVersion: v1.2
class: CommandLineTool
baseCommand: profphd-net
label: profphd-net
doc: The provided text does not contain help information or a description of the tool;
  it contains error logs from a container runtime (Apptainer/Singularity) attempting
  to fetch the tool's image.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profphd-net:v1.0.22-6-deb_cv1
stdout: profphd-net.out
