cwlVersion: v1.2
class: CommandLineTool
baseCommand: hubward
label: hubward
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) failing
  to pull the hubward image due to insufficient disk space.\n\nTool homepage: https://github.com/lh3/bwa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hubward:0.2.2--py27_1
stdout: hubward.out
