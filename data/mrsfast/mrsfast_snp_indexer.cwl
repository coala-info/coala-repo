cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrsfast_snp_indexer
label: mrsfast_snp_indexer
doc: "The provided text does not contain help information for mrsfast_snp_indexer.
  It contains system error messages related to a container runtime (Apptainer/Singularity)
  failing due to insufficient disk space.\n\nTool homepage: https://github.com/sfu-compbio/mrsfast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrsfast:3.4.2--h577a1d6_5
stdout: mrsfast_snp_indexer.out
