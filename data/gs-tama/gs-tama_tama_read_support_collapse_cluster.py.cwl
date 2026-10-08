cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_read_support_collapse_cluster.py
label: gs-tama_tama_read_support_collapse_cluster.py
doc: "This script gets all read support for TAMA collapse transcripts from clustering output\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: collapse_trans_read_bed
    type: File
    doc: TAMA collapse prefix_trans_read.bed file
    inputBinding:
      position: 1
  - id: cluster_file
    type: File
    doc: "Cluster file: Iso-Seq1 cluster_report.csv, Iso-Seq3 cluster file, or the trans_read.bed file when there was no clustering"
    inputBinding:
      position: 2
  - id: output_file_name
    type: string
    doc: Output file name
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Read support file for the collapsed transcripts
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_read_support_collapse_cluster.py.out
