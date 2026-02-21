cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngshmmalign
label: ngshmmalign
doc: "The provided text does not contain help documentation for ngshmmalign; it contains
  error logs related to a container runtime (Apptainer/Singularity) failure due to
  insufficient disk space.\n\nTool homepage: https://github.com/cbg-ethz/ngshmmalign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngshmmalign:0.1.1--0
stdout: ngshmmalign.out
