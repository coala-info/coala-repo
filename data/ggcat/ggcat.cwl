cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggcat
label: ggcat
doc: "The provided text does not contain help information or a description of the
  tool's functionality. It contains error logs related to a container runtime (Apptainer/Singularity)
  failing to pull the ggcat image due to insufficient disk space.\n\nTool homepage:
  https://github.com/algbio/ggcat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggcat:2.0.0--ha96b9cd_0
stdout: ggcat.out
