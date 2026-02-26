cwlVersion: v1.2
class: CommandLineTool
baseCommand: somatic-variant-filters
label: sga_somatic-variant-filters
doc: "Filters somatic variants based on tumor and normal BAM files and a reference
  genome.\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: filter_germline
    type:
      - 'null'
      - boolean
    doc: Filter out variants that appear to be germline.
    inputBinding:
      position: 101
      prefix: --filter-germline
  - id: filter_homopolymer
    type:
      - 'null'
      - boolean
    doc: Filter out variants in homopolymer regions.
    inputBinding:
      position: 101
      prefix: --filter-homopolymer
  - id: filter_low_quality
    type:
      - 'null'
      - boolean
    doc: Filter out variants with low quality scores.
    inputBinding:
      position: 101
      prefix: --filter-low-quality
  - id: filter_recurrent
    type:
      - 'null'
      - boolean
    doc: Filter out variants that are recurrent in the normal sample.
    inputBinding:
      position: 101
      prefix: --filter-recurrent
  - id: filter_strand_bias
    type:
      - 'null'
      - boolean
    doc: Filter out variants with significant strand bias.
    inputBinding:
      position: 101
      prefix: --filter-strand-bias
  - id: max_normal_alt_fraction
    type:
      - 'null'
      - float
    doc: Maximum alternate allele fraction in the normal sample.
    default: 0.05
    inputBinding:
      position: 101
      prefix: --max-normal-alt-fraction
  - id: min_normal_allele_fraction
    type:
      - 'null'
      - float
    doc: Maximum allele fraction in the normal sample to consider a variant 
      somatic.
    default: 0.01
    inputBinding:
      position: 101
      prefix: --min-normal-allele-fraction
  - id: min_normal_alt_count
    type:
      - 'null'
      - int
    doc: Maximum alternate allele count in the normal sample.
    default: 0
    inputBinding:
      position: 101
      prefix: --min-normal-alt-count
  - id: min_normal_depth
    type:
      - 'null'
      - int
    doc: Minimum depth in the normal sample to consider a variant.
    default: 10
    inputBinding:
      position: 101
      prefix: --min-normal-depth
  - id: min_tumor_allele_fraction
    type:
      - 'null'
      - float
    doc: Minimum allele fraction in the tumor sample to consider a variant.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min-tumor-allele-fraction
  - id: min_tumor_alt_count
    type:
      - 'null'
      - int
    doc: Minimum alternate allele count in the tumor sample.
    default: 3
    inputBinding:
      position: 101
      prefix: --min-tumor-alt-count
  - id: min_tumor_depth
    type:
      - 'null'
      - int
    doc: Minimum depth in the tumor sample to consider a variant.
    default: 10
    inputBinding:
      position: 101
      prefix: --min-tumor-depth
  - id: normal_bam
    type: File
    doc: Path to the normal BAM file.
    inputBinding:
      position: 101
      prefix: --normal-bam
  - id: reference
    type: File
    doc: Path to the reference genome FASTA file.
    inputBinding:
      position: 101
      prefix: --reference
  - id: tumor_bam
    type: File
    doc: Path to the tumor BAM file.
    inputBinding:
      position: 101
      prefix: --tumor-bam
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Path to the output VCF file.
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
