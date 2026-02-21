cwlVersion: v1.2
class: CommandLineTool
baseCommand: eqtlbma_controlBayesFdr
label: eqtlbma_controlBayesFdr
doc: "The provided text does not contain help information for the tool, as it consists
  of system error messages related to a container runtime (Singularity/Apptainer)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/timflutre/eqtlbma"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eqtlbma:1.3.3--h3dbd7e7_0
stdout: eqtlbma_controlBayesFdr.out
