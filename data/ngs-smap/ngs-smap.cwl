cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngs-smap
label: ngs-smap
doc: "The provided text does not contain help information or usage instructions. It
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the docker image due to lack of disk space.\n\nTool homepage: https://gitlab.com/truttink/smap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
stdout: ngs-smap.out
