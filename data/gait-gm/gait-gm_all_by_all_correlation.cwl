cwlVersion: v1.2
class: CommandLineTool
baseCommand: gait-gm_all_by_all_correlation
label: gait-gm_all_by_all_correlation
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/secimTools/gait-gm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
stdout: gait-gm_all_by_all_correlation.out
