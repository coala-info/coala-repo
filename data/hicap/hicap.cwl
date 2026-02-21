cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicap
label: hicap
doc: "The provided text does not contain help documentation or usage instructions
  for the tool. It consists of error logs from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/scwatts/hicap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicap:1.0.4--pyhdfd78af_2
stdout: hicap.out
