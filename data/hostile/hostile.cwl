cwlVersion: v1.2
class: CommandLineTool
baseCommand: hostile
label: hostile
doc: "The provided text does not contain help information or a description of the
  tool; it consists of error logs from a container runtime (Apptainer/Singularity)
  indicating a failure to build the SIF image due to insufficient disk space.\n\n
  Tool homepage: https://github.com/bede/hostile"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hostile:2.0.2--pyhdfd78af_0
stdout: hostile.out
