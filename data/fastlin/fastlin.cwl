cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastlin
label: fastlin
doc: "fastlin\n\nTool homepage: https://github.com/rderelle/fastlin"
inputs:
  - id: barcodes
    type: File
    doc: file containing the reference barcodes
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: dir
    type: Directory
    doc: directory containing the data files
    inputBinding:
      position: 101
      prefix: --dir
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: max_cov
    type:
      - 'null'
      - string
    doc: maximum kmer coverage
    inputBinding:
      position: 101
      prefix: --max-cov
  - id: min_count
    type:
      - 'null'
      - int
    doc: minimum number of kmer occurences
    inputBinding:
      position: 101
      prefix: --min-count
  - id: n_barcodes
    type:
      - 'null'
      - int
    doc: minimum number of barcodes
    inputBinding:
      position: 101
      prefix: --n-barcodes
  - id: nb_threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --nb-threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastlin:0.4.2.1--h4349ce8_0
