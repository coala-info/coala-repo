cwlVersion: v1.2
class: CommandLineTool
baseCommand: [LRez, index, fastq]
label: mtglink_LRez_index_fastq
doc: "Index the offsets of the barcodes contained in a FASTQ file.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: fastq
    type: File
    doc: "FASTQ file to index (LRez writes a .gzi index beside it when gzipped)"
    inputBinding:
      prefix: -f
      valueFrom: $(self.basename)
  - id: output
    type: string
    doc: "File where to store the index"
    inputBinding:
      prefix: -o
  - id: gzip
    type: ['null', boolean]
    doc: "FASTQ file is gzipped (default: false)"
    inputBinding:
      prefix: -g
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use to build the index (default: 1)"
    inputBinding:
      prefix: -t
outputs:
  - id: result
    type: File
    doc: Barcode index
    outputBinding:
      glob: $(inputs.output)
  - id: gzip_index
    type: ['null', File]
    doc: BGZF block index (.gzi) written beside the gzipped FASTQ
    outputBinding:
      glob: '*.gzi'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.fastq.basename)
        entry: $(inputs.fastq)
        writable: true
