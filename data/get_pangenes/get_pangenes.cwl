cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_pangenes
label: get_pangenes
doc: "The provided text does not contain help information for the tool, but rather
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/Ensembl/plant-scripts/tree/master/pangenes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_fasta_info:2.5.0--h577a1d6_0
stdout: get_pangenes.out
