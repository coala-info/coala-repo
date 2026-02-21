cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - eqtlbma_bf
label: eqtlbma_eqtlbma_bf
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull a Docker image due to lack of disk space.\n\nTool homepage: https://github.com/timflutre/eqtlbma"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eqtlbma:1.3.3--h3dbd7e7_0
stdout: eqtlbma_eqtlbma_bf.out
