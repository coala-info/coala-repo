cwlVersion: v1.2
class: CommandLineTool
baseCommand: infinity
label: infinity
doc: "The provided text does not contain help information or a description for the
  tool 'infinity'. It contains error logs from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container image due to lack of disk space.\n\n
  Tool homepage: https://github.com/kvesteri/infinity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infinity:1.4--py35_0
stdout: infinity.out
