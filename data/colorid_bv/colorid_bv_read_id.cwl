cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - colorid_bv
  - read_id
label: colorid_bv_read_id
doc: "id's reads\n\nTool homepage: https://github.com/hcdenbakker/colorid_bv"
inputs:
  - id: batch
    type:
      - 'null'
      - int
    doc: Sets size of batch of reads to be processed in parallel
    inputBinding:
      position: 101
      prefix: --batch
  - id: bigsi
    type: File
    doc: index to be used for search
    inputBinding:
      position: 101
      prefix: --bigsi
  - id: bitvector_sample
    type:
      - 'null'
      - int
    doc: Collects matches for subset of kmers indicated, using this subset to more
      rapidly find hits for the remainder of the kmers
    inputBinding:
      position: 101
      prefix: --bitvector_sample
  - id: down_sample
    type:
      - 'null'
      - int
    doc: down-sample k-mers used for read classification; increases speed at cost
      of decreased sensitivity
    inputBinding:
      position: 101
      prefix: --down_sample
  - id: fp_correct
    type:
      - 'null'
      - int
    doc: Parameter to correct for false positives, maybe increased for larger searches.
      Adjust for larger datasets
    inputBinding:
      position: 101
      prefix: --fp_correct
  - id: high_mem_load
    type:
      - 'null'
      - boolean
    doc: When this flag is set, a faster, but less memory efficient method to load
      the index is used. Loading the index requires approximately 2X the size of the
      index of RAM.
    inputBinding:
      position: 101
      prefix: --high_mem_load
  - id: quality
    type:
      - 'null'
      - int
    doc: kmers with nucleotides below this minimum phred score will be excluded from
      the analyses
    inputBinding:
      position: 101
      prefix: --quality
  - id: query
    type:
      type: array
      items: File
    doc: query file(-s)fastq.gz
    inputBinding:
      position: 101
      prefix: --query
  - id: supress_taxon
    type:
      - 'null'
      - string
    doc: Taxon to be supressed, for modelling/training purposes
    inputBinding:
      position: 101
      prefix: --supress_taxon
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use, if not set the maximum available number threads
      will be used
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: prefix
    type: File
    doc: prefix for output file(-s)
    outputBinding:
      glob: $(inputs.prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
