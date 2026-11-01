cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- SelectVariants
label: gatk_SelectVariants
doc: |-
  This tool makes it possible to select a subset of variants based on various criteria in order to facilitate certain analyses. Examples include comparing and contrasting cases vs. controls, extracting variant or non-variant loci that meet certain requirements, or troubleshooting some unexpected results, to name a few.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: output
  type: string
  doc: Path to which variants should be written
  inputBinding:
    position: 1
    prefix: --output
- id: variant
  type: File
  doc: A VCF file containing variants
  inputBinding:
    position: 1
    prefix: --variant
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: apply_jexl_filters_first
  type:
  - 'null'
  - boolean
  doc: 'Apply JEXL-based filtering before subsetting samples Possible values: true,
    false.'
  inputBinding:
    position: 1
    prefix: --apply-jexl-filters-first
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: call_genotypes
  type:
  - 'null'
  - boolean
  doc: 'Output called genotypes in final VCF (otherwise no-call) Possible values:
    true, false.'
  inputBinding:
    position: 1
    prefix: --call-genotypes
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: concordance
  type:
  - 'null'
  - File
  doc: Output variants also called in this comparison track
  inputBinding:
    position: 1
    prefix: --concordance
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: discordance
  type:
  - 'null'
  - File
  doc: Output variants not called in this comparison track
  inputBinding:
    position: 1
    prefix: --discordance
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: drop_genotype_annotation
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --drop-genotype-annotation
  doc: Genotype annotations to drop from output vcf. Annotations to be dropped are
    specified by their key.
  inputBinding:
    position: 1
- id: drop_info_annotation
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --drop-info-annotation
  doc: Info annotations to drop from output vcf. Annotations to be dropped are specified
    by their key.
  inputBinding:
    position: 1
- id: exclude_filtered
  type:
  - 'null'
  - boolean
  doc: 'Don''t include filtered sites Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --exclude-filtered
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: exclude_ids
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --exclude-ids
  doc: List of variant rsIDs to exclude
  inputBinding:
    position: 1
- id: exclude_intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --exclude-intervals
  doc: One or more genomic intervals to exclude from processing
  inputBinding:
    position: 1
- id: exclude_non_variants
  type:
  - 'null'
  - boolean
  doc: 'Don''t include non-variant sites Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --exclude-non-variants
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: exclude_sample_expressions
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --exclude-sample-expressions
  doc: List of sample expressions to exclude
  inputBinding:
    position: 1
- id: exclude_sample_name
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --exclude-sample-name
  doc: Exclude genotypes from this sample
  inputBinding:
    position: 1
- id: genomicsdb_max_alternate_alleles
  type:
  - 'null'
  - int
  doc: Maximum number of alternate alleles that will be combined on reading from GenomicsDB
  inputBinding:
    position: 1
    prefix: --genomicsdb-max-alternate-alleles
- id: genomicsdb_shared_posixfs_optimizations
  type:
  - 'null'
  - boolean
  doc: 'Allow for optimizations to improve the usability and performance for shared
    Posix Filesystems(e.g. NFS, Lustre). If set, file level locking is disabled and
    file system writes are minimized. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --genomicsdb-shared-posixfs-optimizations
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: genomicsdb_use_gcs_hdfs_connector
  type:
  - 'null'
  - boolean
  doc: 'Use the GCS HDFS Connector instead of the native GCS SDK client with gs://
    URLs. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --genomicsdb-use-gcs-hdfs-connector
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_non_ref_in_types
  type:
  - 'null'
  - boolean
  doc: 'If set, NON_REF alleles will be ignored for variant type determination, which
    is required for filtering GVCF files by type Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --ignore-non-ref-in-types
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: input
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --input
  doc: BAM/SAM/CRAM file containing reads
  inputBinding:
    position: 1
- id: intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate
  inputBinding:
    position: 1
- id: invert_mendelian_violation
  type:
  - 'null'
  - boolean
  doc: 'Output non-mendelian violation sites only Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --invert-mendelian-violation
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: invertselect
  type:
  - 'null'
  - boolean
  doc: 'Invert the selection criteria for -select Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --invertSelect
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: keep_ids
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --keep-ids
  doc: List of variant rsIDs to select
  inputBinding:
    position: 1
- id: keep_original_ac
  type:
  - 'null'
  - boolean
  doc: 'Store the original AC, AF, and AN values after subsetting Possible values:
    true, false.'
  inputBinding:
    position: 1
    prefix: --keep-original-ac
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: keep_original_dp
  type:
  - 'null'
  - boolean
  doc: 'Store the original DP value after subsetting Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --keep-original-dp
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: max_filtered_genotypes
  type:
  - 'null'
  - int
  doc: Maximum number of samples filtered at the genotype level
  inputBinding:
    position: 1
    prefix: --max-filtered-genotypes
- id: max_fraction_filtered_genotypes
  type:
  - 'null'
  - double
  doc: Maximum fraction of samples filtered at the genotype level
  inputBinding:
    position: 1
    prefix: --max-fraction-filtered-genotypes
- id: max_indel_size
  type:
  - 'null'
  - int
  doc: Maximum size of indels to include
  inputBinding:
    position: 1
    prefix: --max-indel-size
- id: max_nocall_fraction
  type:
  - 'null'
  - double
  doc: Maximum fraction of samples with no-call genotypes
  inputBinding:
    position: 1
    prefix: --max-nocall-fraction
- id: max_nocall_number
  type:
  - 'null'
  - int
  doc: Maximum number of samples with no-call genotypes
  inputBinding:
    position: 1
    prefix: --max-nocall-number
- id: mendelian_violation
  type:
  - 'null'
  - boolean
  doc: 'Output mendelian violation sites only Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --mendelian-violation
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: mendelian_violation_qual_threshold
  type:
  - 'null'
  - double
  doc: Minimum GQ score for each trio member to accept a site as a violation
  inputBinding:
    position: 1
    prefix: --mendelian-violation-qual-threshold
- id: min_filtered_genotypes
  type:
  - 'null'
  - int
  doc: Minimum number of samples filtered at the genotype level
  inputBinding:
    position: 1
    prefix: --min-filtered-genotypes
- id: min_fraction_filtered_genotypes
  type:
  - 'null'
  - double
  doc: Maximum fraction of samples filtered at the genotype level
  inputBinding:
    position: 1
    prefix: --min-fraction-filtered-genotypes
- id: min_indel_size
  type:
  - 'null'
  - int
  doc: Minimum size of indels to include
  inputBinding:
    position: 1
    prefix: --min-indel-size
- id: pedigree
  type:
  - 'null'
  - File
  doc: Pedigree file
  inputBinding:
    position: 1
    prefix: --pedigree
- id: preserve_alleles
  type:
  - 'null'
  - boolean
  doc: 'Preserve original alleles, do not trim Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --preserve-alleles
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence
  inputBinding:
    position: 1
    prefix: --reference
  secondaryFiles:
  - .fai
  - ^.dict
- id: remove_fraction_genotypes
  type:
  - 'null'
  - double
  doc: Select a fraction of genotypes at random from the input and sets them to no-call
  inputBinding:
    position: 1
    prefix: --remove-fraction-genotypes
- id: remove_unused_alternates
  type:
  - 'null'
  - boolean
  doc: 'Remove alternate alleles not present in any genotypes Possible values: true,
    false.'
  inputBinding:
    position: 1
    prefix: --remove-unused-alternates
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: restrict_alleles_to
  type:
  - 'null'
  - string
  doc: 'Select only variants of a particular allelicity Possible values: ALL, BIALLELIC,
    MULTIALLELIC.'
  inputBinding:
    position: 1
    prefix: --restrict-alleles-to
- id: sample_expressions
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --sample-expressions
  doc: Regular expression to select multiple samples
  inputBinding:
    position: 1
- id: sample_name
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --sample-name
  doc: Include genotypes from this sample
  inputBinding:
    position: 1
- id: select
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --select
  doc: A filtering expression in terms of either INFO fields or the VariantContext
    object). If the expression evaluates to true for a variant, it will be kept in
    the output vcf.
  inputBinding:
    position: 1
- id: select_genotype_expressions
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --select-genotype-expressions
  doc: A filtering expression in terms of FORMAT fields. If the expression evaluates
    to true for a variant, it will be kept in the output vcf.
  inputBinding:
    position: 1
- id: select_random_fraction
  type:
  - 'null'
  - double
  doc: Select a fraction of variants at random from the input
  inputBinding:
    position: 1
    prefix: --select-random-fraction
- id: select_type_to_exclude
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --select-type-to-exclude
  doc: 'Do not select certain type of variants from the input file Possible values:
    NO_VARIATION, SNP, MNP, INDEL, SYMBOLIC, MIXED.'
  inputBinding:
    position: 1
- id: select_type_to_include
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --select-type-to-include
  doc: 'Select only a certain type of variants from the input file Possible values:
    NO_VARIATION, SNP, MNP, INDEL, SYMBOLIC, MIXED.'
  inputBinding:
    position: 1
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
    Must be a .dict file.
  inputBinding:
    position: 1
    prefix: --sequence-dictionary
- id: set_filtered_gt_to_nocall
  type:
  - 'null'
  - boolean
  doc: 'Set filtered genotypes to no-call Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --set-filtered-gt-to-nocall
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: genomicsdb_use_bcf_codec
  type:
  - 'null'
  - boolean
  doc: 'Use BCF Codec Streaming for data from GenomicsDB instead of the default VCFCodec.
    BCFCodec performs slightly better but currently does not support 64-bit width
    positions and INFO fields and for computed annotation sizes to exceed 32-bit integer
    space. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --genomicsdb-use-bcf-codec
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: variant_output_filtering
  type:
  - 'null'
  - string
  doc: Restrict the output variants to ones that match the specified intervals according
    to the specified matching mode.
  inputBinding:
    position: 1
    prefix: --variant-output-filtering
outputs:
- id: output_file
  type: File
  doc: Path to which variants should be written
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
