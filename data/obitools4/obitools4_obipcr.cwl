cwlVersion: v1.2
class: CommandLineTool
baseCommand: obipcr
label: obitools4_obipcr
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failure.\n
  \nTool homepage: https://obitools4.metabarcoding.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obipcr.out
