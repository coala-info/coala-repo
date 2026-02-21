cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmalign
label: infernal_cmalign
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull an image due to insufficient disk space.\n\nTool homepage: http://eddylab.org/infernal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
stdout: infernal_cmalign.out
