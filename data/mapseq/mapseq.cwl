cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapseq
label: mapseq
doc: "The provided text does not contain help information for mapseq; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/jfmrod/MAPseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapseq:2.1.1--ha34dc8c_0
stdout: mapseq.out
