cwlVersion: v1.2
class: CommandLineTool
baseCommand: IntaRNA
label: intarna_IntaRNAseed
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Singularity/Apptainer) indicating a failure to pull
  or build the container image due to insufficient disk space.\n\nTool homepage: https://github.com/BackofenLab/IntaRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
stdout: intarna_IntaRNAseed.out
