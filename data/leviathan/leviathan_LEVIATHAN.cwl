cwlVersion: v1.2
class: CommandLineTool
baseCommand: LEVIATHAN
label: leviathan_LEVIATHAN
doc: "Linked-reads based structural variant caller with barcode indexing\n\nTool homepage:
  https://github.com/morispi/LEVIATHAN"
inputs:
  - id: bamFile
    type: File
    doc: 'BAM file to analyze. Warning: the associated .bai file must exist'
    inputBinding:
      position: 101
      prefix: -b
  - id: barcodeIndex
    type: File
    doc: LRez barcode occurrence positions index of the BAM file
    inputBinding:
      position: 101
      prefix: -i
  - id: candidates_file
    type:
      - 'null'
      - File
    doc: File where to store valid SV candidates
    default: candidates.bedpe
    inputBinding:
      position: 101
      prefix: --candidates
  - id: duplicates_distance
    type:
      - 'null'
      - int
    doc: Consider SV as duplicates if they have the same type and if their 
      breakpoints are within this distance
    default: 10
    inputBinding:
      position: 101
      prefix: --duplicates
  - id: genome
    type: File
    doc: The reference genome in FASTA format
    inputBinding:
      position: 101
      prefix: -g
  - id: large_rate
    type:
      - 'null'
      - float
    doc: Percentile to chose as a threshold in the distribution of the number of
      shared barcodes for large variants
    default: 99
    inputBinding:
      position: 101
      prefix: --largeRate
  - id: large_size
    type:
      - 'null'
      - int
    doc: Minimum size of large variants
    default: 10000
    inputBinding:
      position: 101
      prefix: --largeSize
  - id: max_links
    type:
      - 'null'
      - int
    doc: Remove from candidates list all candidates which have a region involved
      in that much candidates
    default: 1000
    inputBinding:
      position: 101
      prefix: --maxLinks
  - id: medium_rate
    type:
      - 'null'
      - float
    doc: Percentile to chose as a threshold in the distribution of the number of
      shared barcodes for medium variants
    default: 99
    inputBinding:
      position: 101
      prefix: --mediumRate
  - id: medium_size
    type:
      - 'null'
      - int
    doc: Minimum size of medium variants
    default: 2000
    inputBinding:
      position: 101
      prefix: --mediumSize
  - id: min_barcodes
    type:
      - 'null'
      - int
    doc: Always remove candidates that share less than this number of barcodes
    default: 1
    inputBinding:
      position: 101
      prefix: --minBarcodes
  - id: min_variant_size
    type:
      - 'null'
      - int
    doc: Minimum size of the SVs to detect
    inputBinding:
      position: 101
      prefix: --minVariantSize
  - id: nb_bins
    type:
      - 'null'
      - int
    doc: Number of iterations to perform through the barcode index
    default: 10
    inputBinding:
      position: 101
      prefix: --nbBins
  - id: pool_size
    type:
      - 'null'
      - int
    doc: Size of the thread pool
    default: 100000
    inputBinding:
      position: 101
      prefix: --poolSize
  - id: region_size
    type:
      - 'null'
      - int
    doc: Size of the regions on the reference genome to consider
    default: 1000
    inputBinding:
      position: 101
      prefix: --regionSize
  - id: skip_translocations
    type:
      - 'null'
      - boolean
    doc: Do not process SVs which are translocations
    default: false
    inputBinding:
      position: 101
      prefix: --skipTranslocations
  - id: small_rate
    type:
      - 'null'
      - float
    doc: Percentile to chose as a threshold in the distribution of the number of
      shared barcodes for small variants
    default: 99
    inputBinding:
      position: 101
      prefix: --smallRate
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_vcf
    type: File
    doc: VCF file where to ouput the SVs
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
