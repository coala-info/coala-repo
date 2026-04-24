cwlVersion: v1.2
class: CommandLineTool
baseCommand: FragGeneScanRs
label: frag_gene_scan_rs
doc: "FragGeneScanRs is a faster implementation of FragGeneScan for predicting genes
  in short and error-prone DNA reads.\n\nTool homepage: https://github.com/unipept/FragGeneScanRs"
inputs:
  - id: sequence
    type: File
    doc: The input sequence file (FASTA format)
    inputBinding:
      position: 101
      prefix: --sequence
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use
    inputBinding:
      position: 101
      prefix: --thread
  - id: training
    type: string
    doc: The training model to use (e.g., complete, sanger_10, sanger_5, illumina_10,
      illumina_5, or 454_10, 454_30, 454_50)
    inputBinding:
      position: 101
      prefix: --training
outputs:
  - id: output
    type: File
    doc: The output file prefix
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frag_gene_scan_rs:1.1.0--h4349ce8_0
