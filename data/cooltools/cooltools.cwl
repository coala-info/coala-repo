cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooltools
label: cooltools
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull or build the cooltools image due to insufficient disk space.\n\n\
  Tool homepage: https://github.com/mirnylab/cooltools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
stdout: cooltools.out
