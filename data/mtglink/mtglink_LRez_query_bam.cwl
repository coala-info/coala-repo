cwlVersion: v1.2
class: CommandLineTool
baseCommand: [LRez, query, bam]
label: mtglink_LRez_query_bam
doc: "Query a barcodes index and a BAM file to retrieve alignments containing the query barcodes (returned in SAM format).\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: bam
    type: File
    doc: "BAM file to search"
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      prefix: -b
  - id: index
    type: File
    doc: "Barcodes offsets index, built with the index bam subcommand"
    inputBinding:
      prefix: -i
  - id: query
    type: ['null', string]
    doc: "Query barcode to search in the BAM / index"
    inputBinding:
      prefix: -q
  - id: list
    type: ['null', File]
    doc: "File containing a list of barcodes to search in the BAM / index"
    inputBinding:
      prefix: -l
  - id: output
    type: string
    doc: "File where to output the extracted alignments"
    inputBinding:
      prefix: -o
  - id: header
    type: ['null', boolean]
    doc: "Output SAM header (default: false)"
    inputBinding:
      prefix: -H
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use when querying with a list of barcodes (default: 1)"
    inputBinding:
      prefix: -t
outputs:
  - id: result
    type: File
    doc: Alignments in SAM format
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
