cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - somatic-variant-filters
label: sga_somatic-variant-filters
doc: 'Count read support for variants in a vcf file and filter low-quality somatic variants.


  Tool homepage: https://github.com/jts/sga'
inputs:
  - id: tumor_bam
    type: File
    doc: Load the aligned tumor reads from FILE (indexed BAM).
    inputBinding:
      position: 1
      prefix: --tumor-bam
      valueFrom: $(self.basename)
    secondaryFiles:
      - .bai
  - id: normal_bam
    type: File
    doc: Load the aligned normal reads from FILE (indexed BAM).
    inputBinding:
      position: 2
      prefix: --normal-bam
      valueFrom: $(self.basename)
    secondaryFiles:
      - .bai
  - id: reference
    type: File
    doc: Load the reference genome from FILE.
    inputBinding:
      position: 3
      prefix: --reference
      valueFrom: $(self.basename)
    secondaryFiles:
      - .fai
  - id: annotate_only
    type:
      - 'null'
      - boolean
    doc: Only annotate with INFO tags, rather than filter.
    inputBinding:
      position: 4
      prefix: --annotate-only
  - id: min_af
    type:
      - 'null'
      - float
    doc: Minimum allele frequency (AF tag).
    inputBinding:
      position: 5
      prefix: --min-af
  - id: min_var_dp
    type:
      - 'null'
      - int
    doc: Minimum variant depth (VarDP).
    inputBinding:
      position: 6
      prefix: --min-var-dp
  - id: max_strand_bias
    type:
      - 'null'
      - float
    doc: Maximum strand bias (SB).
    inputBinding:
      position: 7
      prefix: --max-strand-bias
  - id: max_hp_length
    type:
      - 'null'
      - int
    doc: Maximum homopolymer context length (HPlen).
    inputBinding:
      position: 8
      prefix: --max-hp-length
  - id: max_dust
    type:
      - 'null'
      - float
    doc: Maximum dust scores (Dust).
    inputBinding:
      position: 9
      prefix: --max-dust
  - id: max_normal_reads
    type:
      - 'null'
      - int
    doc: Maximum normal reads showing variant.
    inputBinding:
      position: 10
      prefix: --max-normal-reads
  - id: min_normal_depth
    type:
      - 'null'
      - int
    doc: Minimum normal depth at the locus.
    inputBinding:
      position: 11
      prefix: --min-normal-depth
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Use NUM threads to compute the overlaps (default: 1).'
    inputBinding:
      position: 12
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display verbose output.
    inputBinding:
      position: 13
      prefix: --verbose
  - id: vcf_file
    type: File
    doc: VCF file of somatic variant calls (from sga graph-diff).
    inputBinding:
      position: 14
      valueFrom: $(self.basename)
outputs:
  - id: filtered_vcf
    type: stdout
    doc: Filtered or annotated VCF written to standard output.
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.tumor_bam)
      - $(inputs.normal_bam)
      - $(inputs.reference)
      - $(inputs.vcf_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_somatic-variant-filters.vcf
