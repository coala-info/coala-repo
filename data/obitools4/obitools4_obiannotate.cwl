cwlVersion: v1.2
class: CommandLineTool
baseCommand: obiannotate
label: obitools4_obiannotate
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to lack of disk space.\n\nTool
  homepage: https://obitools4.metabarcoding.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obiannotate.out
