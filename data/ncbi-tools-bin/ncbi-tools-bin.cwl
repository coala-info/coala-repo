cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-tools-bin
label: ncbi-tools-bin
doc: The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or usage instructions for the tool. It indicates
  a failure to build the container image due to insufficient disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-tools-bin:v6.1.20170106-6-deb_cv1
stdout: ncbi-tools-bin.out
