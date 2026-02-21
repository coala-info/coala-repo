cwlVersion: v1.2
class: CommandLineTool
baseCommand: eqtlbma
label: eqtlbma
doc: "The provided text does not contain help information for eqtlbma. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/timflutre/eqtlbma"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eqtlbma:1.3.3--h3dbd7e7_0
stdout: eqtlbma.out
