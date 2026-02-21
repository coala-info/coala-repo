cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_orfs
label: get_orfs
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull an image due to insufficient disk space.\n\nTool homepage: https://github.com/linsalrob/get_orfs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_fasta_info:2.5.0--h577a1d6_0
stdout: get_orfs.out
