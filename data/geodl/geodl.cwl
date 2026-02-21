cwlVersion: v1.2
class: CommandLineTool
baseCommand: geodl
label: geodl
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log from a container runtime (Singularity/Apptainer)
  indicating a failure to pull or build the container image due to lack of disk space.\n
  \nTool homepage: https://github.com/jduc/geoDL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geodl:1.0b5.1--py36_0
stdout: geodl.out
