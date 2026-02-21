cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex
label: ffindex
doc: "The provided text does not contain help information for ffindex; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the container image due to lack of disk space.\n\nTool homepage: https://github.com/soedinglab/ffindex_soedinglab"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
stdout: ffindex.out
