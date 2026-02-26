cwlVersion: v1.2
class: CommandLineTool
baseCommand: rattle_cluster_summary
label: rattle_cluster_summary
doc: "Generates a summary of clustering results from input FASTA/FASTQ and cluster
  files.\n\nTool homepage: https://github.com/comprna/RATTLE"
inputs:
  - id: clusters_file
    type: File
    doc: clusters file (required)
    inputBinding:
      position: 101
      prefix: --clusters
  - id: input_file
    type: File
    doc: input fasta/fastq file (required)
    inputBinding:
      position: 101
      prefix: --input
  - id: label
    type:
      - 'null'
      - type: array
        items: string
    doc: labels for the files in order of entry
    inputBinding:
      position: 101
      prefix: --label
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rattle:1.0--h5ca1c30_0
stdout: rattle_cluster_summary.out
