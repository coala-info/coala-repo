cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_homologues
label: get_homologues
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failure
  due to lack of disk space.\n\nTool homepage: https://github.com/eead-csic-compbio/get_homologues"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_fasta_info:2.5.0--h577a1d6_0
stdout: get_homologues.out
