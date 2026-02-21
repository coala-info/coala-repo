cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipo_ipopt
label: ipo_ipopt
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the container image due to insufficient disk
  space. It does not contain help text or usage information for the tool.\n\nTool
  homepage: https://github.com/coin-or/Ipopt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ipo:v1.7.5_cv0.3
stdout: ipo_ipopt.out
