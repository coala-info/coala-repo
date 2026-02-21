cwlVersion: v1.2
class: CommandLineTool
baseCommand: firecloud
label: firecloud
doc: "The provided text does not contain help information for the firecloud tool,
  but rather error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to lack of disk space.\n\nTool
  homepage: https://github.com/broadinstitute/fiss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/firecloud:0.16.38--pyhdfd78af_0
stdout: firecloud.out
