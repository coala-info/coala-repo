cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/src/physlr-makebf]
label: physlr_makebf
doc: "Make a Bloom filter of repetitive k-mers from ntHits output files.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: kmer_size
    type: int
    doc: "use K as k-mer size"
    inputBinding:
      position: 1
      prefix: -k
  - id: bloom_filter_bytes
    type: ['null', int]
    doc: "Bloom filter size in bytes"
    inputBinding:
      position: 2
      prefix: -b
  - id: verbose
    type: ['null', boolean]
    doc: "enable verbose output"
    inputBinding:
      position: 3
      prefix: -v
  - id: threads
    type: ['null', int]
    doc: "use N number of threads [1]"
    inputBinding:
      position: 4
      prefix: -t
  - id: output_name
    type: string
    doc: "write the Bloom filter to this file name"
    inputBinding:
      position: 5
      prefix: -o
  - id: nthits_files
    type: File[]
    doc: "ntHits tsv output files"
    inputBinding:
      position: 100
outputs:
  - id: result
    type: File
    doc: "Bloom filter file"
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
