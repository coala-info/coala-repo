cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-calculate-expression
label: rsem_rsem-calculate-expression
doc: "The provided text does not contain help information for rsem-calculate-expression,
  but appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch the tool image.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
stdout: rsem_rsem-calculate-expression.out
