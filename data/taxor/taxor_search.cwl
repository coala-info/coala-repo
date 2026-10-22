cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxor
  - search
label: taxor_search
doc: "Queries files of DNA sequences against a list of HIXF index files\n\nTool homepage: https://github.com/JensUweUlrich/Taxor"
inputs:
  - id: index_file
    type: File
    doc: 'Taxor index file containing HIXF index and reference sequence information'
    inputBinding:
      position: 101
      prefix: --index-file
  - id: query_file
    type: File
    doc: 'File containing sequences (fasta/fastq, optionally gzipped) to query against the index'
    inputBinding:
      position: 101
      prefix: --query-file
  - id: output_file_path
    type: string
    doc: 'A file name for the resulting output'
    inputBinding:
      position: 102
      prefix: --output-file
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of threads to use (default 1, range 1-32)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: percentage
    type:
      - 'null'
      - float
    doc: 'If set, this threshold is used instead of the k-mer/syncmer models (default -1, range 0-1)'
    inputBinding:
      position: 101
      prefix: --percentage
  - id: error_rate
    type:
      - 'null'
      - float
    doc: 'Expected error rate of reads that will be queried (default 0.04, range 0-1)'
    inputBinding:
      position: 101
      prefix: --error-rate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Tab-separated search results
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
stdout: taxor_search.out
