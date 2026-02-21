cwlVersion: v1.2
class: CommandLineTool
baseCommand: muset_kmat_tools
label: muset_kmat_tools
doc: "The provided text does not contain help information or usage instructions. It
  contains system logs and a fatal error message related to a container runtime (Apptainer/Singularity)
  failing to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/CamilaDuitama/muset"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muset:0.5.1--h22625ea_0
stdout: muset_kmat_tools.out
