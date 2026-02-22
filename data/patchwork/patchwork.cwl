cwlVersion: v1.2
class: CommandLineTool
baseCommand: patchwork
label: patchwork
doc: "The provided text does not contain help information or usage instructions for
  the tool 'patchwork'. It contains system error messages related to a container runtime
  (Singularity/Apptainer) failing to pull or build a Docker image due to insufficient
  disk space.\n\nTool homepage: https://github.com/ssbc/patchwork"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/patchwork:0.5.0_cv1
stdout: patchwork.out
