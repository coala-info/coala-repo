cwlVersion: v1.2
class: CommandLineTool
baseCommand: [LRez, query, fastq]
label: mtglink_LRez_query_fastq
doc: "Query a barcodes index and a FASTQ file to retrieve reads containing the query barcodes.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: fastq
    type: File
    doc: "FASTQ file to search"
    inputBinding:
      prefix: -f
      valueFrom: $(self.basename)
  - id: gzip_index
    type: ['null', File]
    doc: "BGZF block index (.gzi) of the gzipped FASTQ, written by index fastq; staged beside the FASTQ"
  - id: index
    type: File
    doc: "Barcodes index, built with the index fastq subcommand"
    inputBinding:
      prefix: -i
  - id: query
    type: ['null', string]
    doc: "Query barcode to search in the FASTQ file and the index"
    inputBinding:
      prefix: -q
  - id: list
    type: ['null', File]
    doc: "File containing a list of barcodes to search in the FASTQ file and the index"
    inputBinding:
      prefix: -l
  - id: collection_of_lists
    type: ['null', File]
    doc: "File of files (FOF): file containing the names of lists of barcodes to search"
    inputBinding:
      prefix: -c
  - id: output
    type: string
    doc: "File where to output the extracted reads"
    inputBinding:
      prefix: -o
  - id: gzip
    type: ['null', boolean]
    doc: "FASTQ file is gzipped (default: false)"
    inputBinding:
      prefix: -g
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use when querying with a list of barcodes (default: 1)"
    inputBinding:
      prefix: -t
outputs:
  - id: result
    type: File
    doc: Extracted reads
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.fastq.basename)
        entry: $(inputs.fastq)
        writable: true
      - entryname: $(inputs.fastq.nameroot).gzi
        entry: $(inputs.gzip_index)
