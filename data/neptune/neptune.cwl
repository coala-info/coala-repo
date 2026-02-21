cwlVersion: v1.2
class: CommandLineTool
baseCommand: neptune
label: neptune
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/iqiyi/Neptune"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neptune:1.2.5--py27h24bf2e0_2
stdout: neptune.out
