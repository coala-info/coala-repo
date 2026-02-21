cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit
label: shapeit
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/odelaneau/shapeit4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit:2.r837--h09b0a5c_1
stdout: shapeit.out
