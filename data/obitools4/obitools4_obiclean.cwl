cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - obiclean
label: obitools4_obiclean
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://obitools4.metabarcoding.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obiclean.out
