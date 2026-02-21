cwlVersion: v1.2
class: CommandLineTool
baseCommand: barriers
label: barriers
doc: "The provided text does not contain help information or usage instructions for
  the tool 'barriers'. It appears to be a fatal error log from a container runtime
  (Apptainer/Singularity) indicating a failure to build or extract the container image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://www.tbi.univie.ac.at/RNA/Barriers/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barriers:1.8.1--pl5321h503566f_4
stdout: barriers.out
