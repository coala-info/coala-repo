cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/src/physlr-indexlr]
label: physlr_indexlr
doc: "Index linked reads (or sequences) with minimizers: write one line per read with its barcode (BX tag, or NA) and its minimizer hashes.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: kmer_size
    type: int
    doc: "use K as k-mer size"
    inputBinding:
      position: 1
      prefix: -k
  - id: window_size
    type: int
    doc: "use W as sliding-window size"
    inputBinding:
      position: 2
      prefix: -w
  - id: repeat_bloom_filter
    type: ['null', File]
    doc: "use a Bloom filter to filter out repetitive minimizers (from physlr-makebf)"
    inputBinding:
      position: 3
      prefix: -r
  - id: solid_bloom_filter
    type: ['null', File]
    doc: "use a Bloom filter to only select solid minimizers"
    inputBinding:
      position: 4
      prefix: -s
  - id: positions
    type: ['null', boolean]
    doc: "include minimizer positions in the output"
    inputBinding:
      position: 5
      prefix: --pos
  - id: strand
    type: ['null', boolean]
    doc: "include minimizer strand in the output"
    inputBinding:
      position: 6
      prefix: --strand
  - id: threads
    type: ['null', int]
    doc: "use N number of threads [1, max 5]"
    inputBinding:
      position: 7
      prefix: -t
  - id: verbose
    type: ['null', boolean]
    doc: "enable verbose output"
    inputBinding:
      position: 8
      prefix: -v
  - id: output_name
    type: ['null', string]
    doc: "write the output to this file name"
    default: physlr_indexlr.tsv
    inputBinding:
      position: 9
      prefix: -o
  - id: reads
    type: File[]
    doc: "FASTQ or FASTA files"
    inputBinding:
      position: 100
outputs:
  - id: result
    type: File
    doc: "TSV table: barcode (or sequence name), a tab, then the space-separated minimizers"
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
