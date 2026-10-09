cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LRez
  - index
  - fastq
label: leviathan_LRez_index_fastq
doc: "Index the offsets of the barcodes contained in a fastq file.\n\nTool homepage: https://github.com/morispi/LEVIATHAN"
inputs:
  - id: fastq
    type: File
    doc: 'Fastq file to index'
    inputBinding:
      position: 1
      prefix: -f
  - id: output_file
    type: string
    doc: 'File where to store the index'
    inputBinding:
      position: 2
      prefix: -o
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: 'Fastq file is gzipped (default: false)'
    inputBinding:
      position: 3
      prefix: -g
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use to build the index (default: 1)'
    inputBinding:
      position: 4
      prefix: -t
outputs:
  - id: output
    type: File
    doc: 'The barcode index'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
