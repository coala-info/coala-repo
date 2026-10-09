cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LRez
  - query
  - bam
label: leviathan_LRez_query_bam
doc: "Query a barcodes index and a BAM file to retrieve the alignments containing the query barcodes, returned in SAM format.\n\nTool homepage: https://github.com/morispi/LEVIATHAN"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: 'BAM file to search'
    inputBinding:
      position: 1
      prefix: -b
  - id: index
    type: File
    doc: 'Barcodes offsets index, built with the index bam subcommand'
    inputBinding:
      position: 2
      prefix: -i
  - id: query
    type:
      - 'null'
      - string
    doc: 'Query barcode to search in the BAM / index'
    inputBinding:
      position: 3
      prefix: -q
  - id: list
    type:
      - 'null'
      - File
    doc: 'File containing a list of barcodes to search in the BAM / index'
    inputBinding:
      position: 4
      prefix: -l
  - id: output_file
    type: string
    doc: 'File where to output the results'
    inputBinding:
      position: 5
      prefix: -o
  - id: header
    type:
      - 'null'
      - boolean
    doc: 'Output SAM header (default: false)'
    inputBinding:
      position: 6
      prefix: -H
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use when querying with a list of barcodes (default: 1)'
    inputBinding:
      position: 7
      prefix: -t
outputs:
  - id: output
    type: File
    doc: 'The matched alignments in SAM format'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
