cwlVersion: v1.2
class: CommandLineTool
baseCommand: vartrix
label: vartrix
doc: "Variant assignment for single cell genomics\n\nTool homepage: https://github.com/10XGenomics/vartrix"
inputs:
  - id: bam_file
    type: File
    doc: Cellranger BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: bam_tag
    type:
      - 'null'
      - string
    doc: BAM tag to consider for marking cells?
    inputBinding:
      position: 101
      prefix: --bam-tag
  - id: cell_barcodes_file
    type: File
    doc: File with cell barcodes to be evaluated
    inputBinding:
      position: 101
      prefix: --cell-barcodes
  - id: fasta_file
    type: File
    doc: Genome fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level
    inputBinding:
      position: 101
      prefix: --log-level
  - id: mapq
    type:
      - 'null'
      - int
    doc: Minimum read mapping quality to consider
    inputBinding:
      position: 101
      prefix: --mapq
  - id: no_duplicates
    type:
      - 'null'
      - boolean
    doc: Do not consider duplicate alignments
    inputBinding:
      position: 101
      prefix: --no-duplicates
  - id: padding
    type:
      - 'null'
      - int
    doc: Number of padding to use on both sides of the variant. Should be at 
      least 1/2 of read length
    inputBinding:
      position: 101
      prefix: --padding
  - id: primary_alignments
    type:
      - 'null'
      - boolean
    doc: Use primary alignments only
    inputBinding:
      position: 101
      prefix: --primary-alignments
  - id: scoring_method
    type:
      - 'null'
      - string
    doc: Type of matrix to produce. In 'consensus' mode, cells with both ref and
      alt reads are given a 3, alt only reads a 2, and ref only reads a 1. 
      Suitable for clustering.  In 'coverage' mode, it is required that you set 
      --ref-matrix to store the second matrix in. The 'alt_frac' mode will 
      report the fraction of alt reads, which is effectively the ratio of the 
      alternate matrix to the sum of the alternate and coverage matrices.
    inputBinding:
      position: 101
      prefix: --scoring-method
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: umi
    type:
      - 'null'
      - boolean
    doc: Consider UMI information when populating coverage matrices?
    inputBinding:
      position: 101
      prefix: --umi
  - id: valid_chars
    type:
      - 'null'
      - string
    doc: Valid characters in an alternative haplotype. This prevents non 
      sequence- resolved variants from being genotyped.
    inputBinding:
      position: 101
      prefix: --valid-chars
  - id: vcf_file
    type: File
    doc: Called variant file (VCF)
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: out_barcodes
    type:
      - 'null'
      - File
    doc: Output cell barcode file. Barcode labels of output matrices. Will have 
      duplicate barcodes removed compared to input barcodes file.
    outputBinding:
      glob: $(inputs.out_barcodes)
  - id: out_matrix
    type:
      - 'null'
      - File
    doc: Output Matrix Market file (.mtx)
    outputBinding:
      glob: $(inputs.out_matrix)
  - id: out_variants
    type:
      - 'null'
      - File
    doc: Output variant file. Reports ordered list of variants to help with 
      loading into downstream tools
    outputBinding:
      glob: $(inputs.out_variants)
  - id: ref_matrix
    type:
      - 'null'
      - File
    doc: Location to write reference Matrix Market file. Only used if 
      --scoring-method is coverage
    outputBinding:
      glob: $(inputs.ref_matrix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vartrix:1.1.22--h9ee0642_6
