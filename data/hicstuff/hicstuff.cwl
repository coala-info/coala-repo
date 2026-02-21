cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicstuff
label: hicstuff
doc: "The provided text does not contain help information for hicstuff; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container due to lack of disk space.\n\nTool homepage: https://github.com/koszullab/hicstuff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicstuff:3.2.4--pyhdfd78af_0
stdout: hicstuff.out
