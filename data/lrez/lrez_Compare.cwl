cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrez_compare
label: lrez_Compare
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull an image due to insufficient disk space.\n\nTool homepage: https://github.com/flegeai/LRez"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrez:2.2.4--h077b44d_4
stdout: lrez_Compare.out
