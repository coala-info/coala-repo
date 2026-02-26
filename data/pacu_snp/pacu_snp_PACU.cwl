cwlVersion: v1.2
class: CommandLineTool
baseCommand: PACU
label: pacu_snp_PACU
doc: "PACU SNP analysis pipeline\n\nTool homepage: https://github.com/BioinformaticsPlatformWIV-ISP/PACU"
inputs:
  - id: bcftools_filt_af1
    type:
      - 'null'
      - boolean
    doc: If enabled, allele frequency filtering also considers the VAF value
    inputBinding:
      position: 101
      prefix: --bcftools-filt-af1
  - id: dir_working
    type:
      - 'null'
      - Directory
    doc: Working directory
    inputBinding:
      position: 101
      prefix: --dir-working
  - id: ilmn_in
    type:
      - 'null'
      - Directory
    doc: Directory with Illumina input BAM files
    inputBinding:
      position: 101
      prefix: --ilmn-in
  - id: image_height
    type:
      - 'null'
      - int
    doc: Image height
    inputBinding:
      position: 101
      prefix: --image-height
  - id: image_width
    type:
      - 'null'
      - int
    doc: Image width
    inputBinding:
      position: 101
      prefix: --image-width
  - id: include_ref
    type:
      - 'null'
      - boolean
    doc: If set, the reference genome is included in the phylogeny
    inputBinding:
      position: 101
      prefix: --include-ref
  - id: min_global_depth
    type:
      - 'null'
      - int
    doc: Minimum depth for all samples to include positions in SNP analysis
    inputBinding:
      position: 101
      prefix: --min-global-depth
  - id: min_mq_depth
    type:
      - 'null'
      - int
    doc: MQ cutoff for samtools depth
    inputBinding:
      position: 101
      prefix: --min-mq-depth
  - id: min_snp_af
    type:
      - 'null'
      - float
    doc: Minimum allele frequency for variants
    inputBinding:
      position: 101
      prefix: --min-snp-af
  - id: min_snp_depth
    type:
      - 'null'
      - int
    doc: Minimum SNP depth
    inputBinding:
      position: 101
      prefix: --min-snp-depth
  - id: min_snp_dist
    type:
      - 'null'
      - int
    doc: Minimum distance between SNPs
    inputBinding:
      position: 101
      prefix: --min-snp-dist
  - id: min_snp_qual
    type:
      - 'null'
      - int
    doc: Minimum SNP quality
    inputBinding:
      position: 101
      prefix: --min-snp-qual
  - id: ont_in
    type:
      - 'null'
      - Directory
    doc: Directory with ONT input BAM files
    inputBinding:
      position: 101
      prefix: --ont-in
  - id: ref_bed
    type:
      - 'null'
      - File
    doc: BED file with phage regions
    inputBinding:
      position: 101
      prefix: --ref-bed
  - id: ref_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --ref-fasta
  - id: skip_gubbins
    type:
      - 'null'
      - boolean
    doc: If set, gubbins is skipped
    inputBinding:
      position: 101
      prefix: --skip-gubbins
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_mega
    type:
      - 'null'
      - boolean
    doc: If set, MEGA is used for the construction of the phylogeny (instead of 
      IQ-TREE)
    inputBinding:
      position: 101
      prefix: --use-mega
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
  - id: output_html
    type:
      - 'null'
      - File
    doc: Output report name
    outputBinding:
      glob: $(inputs.output_html)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacu_snp:1.0.0--pyhdfd78af_0
