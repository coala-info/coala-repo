cwlVersion: v1.2
class: CommandLineTool
baseCommand: [short_read_connector_linker.sh, index]
label: short-read-connector_short_read_connector_linker.sh_index
doc: "Index a read file (short_read_connector linker mode).\n\nTool homepage: https://github.com/GATB/short_read_connector"
inputs:
  - id: bank
    type: File
    doc: "Read file for the bank (fasta/fastq, optionally gzipped)"
    inputBinding:
      position: 101
      prefix: -b
  - id: kmer_size
    type: ['null', int]
    doc: "Length of used kmers (<32). Must fit the compiled value. Default=31"
    inputBinding:
      position: 101
      prefix: -k
  - id: fingerprint_size
    type: ['null', int]
    doc: "Fingerprint size. Size of the key associated to each indexed value, limiting false positives. Default=12"
    inputBinding:
      position: 101
      prefix: -f
  - id: gamma
    type: ['null', int]
    doc: "Gamma value. MPHF expert users parameter. Default=2"
    inputBinding:
      position: 101
      prefix: -G
  - id: kmer_abundance_min
    type: ['null', int]
    doc: "Kmers from the bank seen less than this value are not indexed. Default=2"
    inputBinding:
      position: 101
      prefix: -a
  - id: keep_low_complexity
    type: ['null', boolean]
    doc: "Keep low complexity regions (default false)"
    inputBinding:
      position: 101
      prefix: -l
  - id: threads
    type: ['null', int]
    doc: "Number of threads used. Default=0 (all)"
    inputBinding:
      position: 101
      prefix: -t
  - id: index_name
    type: string
    doc: "Name of the index file to be created, e.g. my_index.dumped"
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_files
    type: File[]
    doc: "Index files created (name given by -i and its companions)"
    outputBinding:
      glob: $(inputs.index_name)*
stdout: short-read-connector_short_read_connector_linker.sh_index.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/short-read-connector:1.2.0--h5ca1c30_3
