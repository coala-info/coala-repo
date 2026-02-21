cwlVersion: v1.2
class: CommandLineTool
baseCommand: grafimo
label: grafimo
doc: "The provided text does not contain help information or usage instructions for
  grafimo. It contains system error messages regarding a container runtime (Apptainer/Singularity)
  failing to build a SIF format image due to insufficient disk space.\n\nTool homepage:
  https://github.com/pinellolab/GRAFIMO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grafimo:1.1.6--py310h79ef01b_0
stdout: grafimo.out
