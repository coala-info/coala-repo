cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordec-trim
label: lordec_lordec-trim
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull or build the image due to lack of disk space.\n\nTool homepage: http://www.atgc-montpellier.fr/lordec/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordec:0.9--ha87ae23_0
stdout: lordec_lordec-trim.out
