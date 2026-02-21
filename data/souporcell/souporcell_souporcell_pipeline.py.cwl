cwlVersion: v1.2
class: CommandLineTool
baseCommand: souporcell_pipeline.py
label: souporcell_souporcell_pipeline.py
doc: "A pipeline for clustering mixed-genotype scRNA-seq data by individual.\n\nTool
  homepage: https://github.com/wheaton5/souporcell"
inputs:
  - id: bam
    type: File
    doc: BAM file of alignments
    inputBinding:
      position: 101
      prefix: --bam
  - id: barcodes
    type: File
    doc: Barcodes file
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: clusters
    type: int
    doc: Number of clusters (individuals)
    inputBinding:
      position: 101
      prefix: --clusters
  - id: common_variants
    type:
      - 'null'
      - File
    doc: VCF file of common variants to use
    inputBinding:
      position: 101
      prefix: --common_variants
  - id: fasta
    type: File
    doc: Reference fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: known_genotypes_sample_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample names in the known genotypes VCF
    inputBinding:
      position: 101
      prefix: --known_genotypes_sample_names
  - id: max_retries
    type:
      - 'null'
      - int
    doc: Maximum retries for clustering
    inputBinding:
      position: 101
      prefix: --max_retries
  - id: min_alt
    type:
      - 'null'
      - int
    doc: Minimum number of alternative reads to consider a variant
    inputBinding:
      position: 101
      prefix: --min_alt
  - id: min_ref
    type:
      - 'null'
      - int
    doc: Minimum number of reference reads to consider a variant
    inputBinding:
      position: 101
      prefix: --min_ref
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Ploidy of the sample
    default: 2
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: skip_remap
    type:
      - 'null'
      - boolean
    doc: Skip the remapping step
    inputBinding:
      position: 101
      prefix: --skip_remap
  - id: specific_genotypes
    type:
      - 'null'
      - File
    doc: VCF file of known genotypes
    inputBinding:
      position: 101
      prefix: --specific_genotypes
  - id: threads
    type: int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
