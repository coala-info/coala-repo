cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-for-ebseq-calculate-clustering-info
label: rsem_rsem-for-ebseq-calculate-clustering-info
doc: "Calculate the clustering information of the transcripts in a reference
  FASTA file, using k-mers. The result is the input of
  rsem-for-ebseq-generate-ngvector-from-clustering-info (EBSeq's isoform
  grouping).\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: k
    type: int
    doc: The k-mer length (an integer).
    inputBinding:
      position: 1
  - id: input_reference_fasta_file
    type: File
    doc: The reference transcript FASTA file (for example reference_name.transcripts.fa).
    inputBinding:
      position: 2
  - id: output_file
    type: string
    doc: The name of the clustering information output file.
    inputBinding:
      position: 3
outputs:
  - id: clustering_info
    type: File
    outputBinding:
      glob: $(inputs.output_file)
    doc: The clustering information file.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
