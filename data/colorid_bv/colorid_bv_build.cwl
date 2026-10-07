cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - colorid_bv
  - build
label: colorid_bv_build
doc: "builds a bigsi\n\nTool homepage: https://github.com/hcdenbakker/colorid_bv"
inputs:
  - id: batch
    type:
      - 'null'
      - int
    doc: Sets size of batch of accessions to be processed in parallel
    inputBinding:
      position: 101
      prefix: --batch
  - id: bloom
    type: int
    doc: Sets the length of the bloom filter
    inputBinding:
      position: 101
      prefix: --bloom
  - id: filter
    type:
      - 'null'
      - int
    doc: minimum coverage kmer threshold (default automatically detected)
    inputBinding:
      position: 101
      prefix: --filter
  - id: kmer
    type: int
    doc: Sets k-mer size
    inputBinding:
      position: 101
      prefix: --kmer
  - id: minimizer
    type:
      - 'null'
      - int
    doc: build index with minimizers of set value
    inputBinding:
      position: 101
      prefix: --minimizer
  - id: num_hashes
    type: int
    doc: Sets number of hashes for bloom filter
    inputBinding:
      position: 101
      prefix: --num_hashes
  - id: quality
    type:
      - 'null'
      - int
    doc: minimum phred score to keep basepairs within read
    inputBinding:
      position: 101
      prefix: --quality
  - id: refs
    type: File
    doc: Sets the input file to use
    inputBinding:
      position: 101
      prefix: --refs
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use, if not set one thread will be used
    inputBinding:
      position: 101
      prefix: --threads
  - id: ref_files
    type:
      - 'null'
      - type: array
        items: File
    doc: reference FASTA/FASTQ files named in the refs file; staged in the 
      working directory so that relative names in the refs file resolve
  - id: bigsi_path
    type: string
    inputBinding:
      position: 102
      prefix: --bigsi
outputs:
  - id: bigsi
    type: Directory
    doc: Sets the bigsi output file
    outputBinding:
      glob: $(inputs.bigsi_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.ref_files ? inputs.ref_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
