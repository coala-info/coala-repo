cwlVersion: v1.2
class: CommandLineTool
baseCommand: nthits-bfq
label: nthits_nthits-bfq
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or run the container due to insufficient disk space.\n
  \nTool homepage: https://github.com/bcgsc/ntHits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nthits:1.0.3--h9948957_2
stdout: nthits_nthits-bfq.out
