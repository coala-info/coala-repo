cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LRez
  - query
  - fastq
label: leviathan_LRez_query_fastq
doc: "Query a barcodes index and a fastq file to retrieve the reads containing the query barcodes.\n\nTool homepage: https://github.com/morispi/LEVIATHAN"
inputs:
  - id: fastq
    type: File
    doc: 'Fastq file to search'
    inputBinding:
      position: 1
      prefix: -f
  - id: index
    type: File
    doc: 'Barcodes index, built with the index fastq subcommand'
    inputBinding:
      position: 2
      prefix: -i
  - id: query
    type:
      - 'null'
      - string
    doc: 'Query barcode to search in the fastq file and the index'
    inputBinding:
      position: 3
      prefix: -q
  - id: list
    type:
      - 'null'
      - File
    doc: 'File containing a list of barcodes to search in the fastq file and the index'
    inputBinding:
      position: 4
      prefix: -l
  - id: collection_of_lists
    type:
      - 'null'
      - File
    doc: 'File of files (FOF) naming files with lists of barcodes to search in the fastq file and the index'
    inputBinding:
      position: 5
      prefix: -c
  - id: output_file
    type: string
    doc: 'File where to output the results'
    inputBinding:
      position: 6
      prefix: -o
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: 'Fastq file is gzipped (default: false)'
    inputBinding:
      position: 7
      prefix: -g
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use when querying with a list of barcodes (default: 1)'
    inputBinding:
      position: 8
      prefix: -t
outputs:
  - id: output
    type: File
    doc: 'The matched reads'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
