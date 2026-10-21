cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - vcffilter
label: rtg-tools_rtg_vcffilter
doc: 'Filters VCF records based on various criteria. When filtering on multiple samples, if any of the specified samples fail the criteria, the record will be filtered. By default filtered records are removed, but see the --fail, --clear-failed-samples, and --fail-samples options for alternatives. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: all_samples
    type:
      - 'null'
      - boolean
    doc: 'apply sample-specific criteria to all samples contained in the input VCF'
    inputBinding:
      position: 101
      prefix: --all-samples
  - id: bed_regions
    type:
      - 'null'
      - File
    doc: 'if set, only read VCF records that overlap the ranges contained in the specified BED file'
    inputBinding:
      position: 101
      prefix: --bed-regions
  - id: input
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: 'VCF file containing variants to be filtered'
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: 'output VCF file'
    inputBinding:
      position: 101
      prefix: --output
  - id: region
    type:
      - 'null'
      - string
    doc: 'if set, only read VCF records within the specified range. The format is one of <sequence_name>, <sequence_name>:<start>-<end>, <sequence_name>:<pos>+<length> or <sequence_name>:<pos>~<padding>'
    inputBinding:
      position: 101
      prefix: --region
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --sample
    doc: 'apply sample-specific criteria to the named sample contained in the input VCF. May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: density_window
    type:
      - 'null'
      - int
    doc: 'window within which multiple variants are discarded'
    inputBinding:
      position: 101
      prefix: --density-window
  - id: exclude_bed
    type:
      - 'null'
      - File
    doc: 'discard all variants within the regions in this BED file'
    inputBinding:
      position: 101
      prefix: --exclude-bed
  - id: exclude_vcf
    type:
      - 'null'
      - File
    doc: 'discard all variants that overlap with the ones in this file'
    inputBinding:
      position: 101
      prefix: --exclude-vcf
  - id: include_bed
    type:
      - 'null'
      - File
    doc: 'only keep variants within the regions in this BED file'
    inputBinding:
      position: 101
      prefix: --include-bed
  - id: include_vcf
    type:
      - 'null'
      - File
    doc: 'only keep variants that overlap with the ones in this file'
    inputBinding:
      position: 101
      prefix: --include-vcf
  - id: javascript
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --javascript
    doc: 'javascript filtering functions for determining whether to keep record. May be either an expression or a file name. May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: keep_expr
    type:
      - 'null'
      - string
    doc: 'records for which this expression evaluates to true will be retained'
    inputBinding:
      position: 101
      prefix: --keep-expr
  - id: keep_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --keep-filter
    doc: 'only keep variants with this FILTER tag. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: keep_info
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --keep-info
    doc: 'only keep variants with this INFO tag. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: max_alleles
    type:
      - 'null'
      - int
    doc: 'maximum number of alleles (REF included)'
    inputBinding:
      position: 101
      prefix: --max-alleles
  - id: max_combined_read_depth
    type:
      - 'null'
      - int
    doc: 'maximum allowed combined read depth'
    inputBinding:
      position: 101
      prefix: --max-combined-read-depth
  - id: max_quality
    type:
      - 'null'
      - float
    doc: 'maximum allowed quality'
    inputBinding:
      position: 101
      prefix: --max-quality
  - id: min_alleles
    type:
      - 'null'
      - int
    doc: 'minimum number of alleles (REF included)'
    inputBinding:
      position: 101
      prefix: --min-alleles
  - id: min_combined_read_depth
    type:
      - 'null'
      - int
    doc: 'minimum allowed combined read depth'
    inputBinding:
      position: 101
      prefix: --min-combined-read-depth
  - id: min_quality
    type:
      - 'null'
      - float
    doc: 'minimum allowed quality'
    inputBinding:
      position: 101
      prefix: --min-quality
  - id: remove_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --remove-filter
    doc: 'remove variants with this FILTER tag. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: remove_info
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --remove-info
    doc: 'remove variants with this INFO tag. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: remove_overlapping
    type:
      - 'null'
      - boolean
    doc: 'remove records that overlap with previous records'
    inputBinding:
      position: 101
      prefix: --remove-overlapping
  - id: max_ambiguity_ratio
    type:
      - 'null'
      - float
    doc: 'maximum allowed ambiguity ratio'
    inputBinding:
      position: 101
      prefix: --max-ambiguity-ratio
  - id: max_avr_score
    type:
      - 'null'
      - float
    doc: 'maximum allowed AVR score'
    inputBinding:
      position: 101
      prefix: --max-avr-score
  - id: max_denovo_score
    type:
      - 'null'
      - float
    doc: 'maximum de novo score threshold'
    inputBinding:
      position: 101
      prefix: --max-denovo-score
  - id: max_genotype_quality
    type:
      - 'null'
      - float
    doc: 'maximum allowed genotype quality'
    inputBinding:
      position: 101
      prefix: --max-genotype-quality
  - id: max_read_depth
    type:
      - 'null'
      - int
    doc: 'maximum allowed sample read depth'
    inputBinding:
      position: 101
      prefix: --max-read-depth
  - id: min_avr_score
    type:
      - 'null'
      - float
    doc: 'minimum allowed AVR score'
    inputBinding:
      position: 101
      prefix: --min-avr-score
  - id: min_denovo_score
    type:
      - 'null'
      - float
    doc: 'minimum de novo score threshold'
    inputBinding:
      position: 101
      prefix: --min-denovo-score
  - id: min_genotype_quality
    type:
      - 'null'
      - float
    doc: 'minimum allowed genotype quality'
    inputBinding:
      position: 101
      prefix: --min-genotype-quality
  - id: min_read_depth
    type:
      - 'null'
      - int
    doc: 'minimum allowed sample read depth'
    inputBinding:
      position: 101
      prefix: --min-read-depth
  - id: non_snps_only
    type:
      - 'null'
      - boolean
    doc: 'only keep where sample variant is MNP or INDEL'
    inputBinding:
      position: 101
      prefix: --non-snps-only
  - id: remove_all_same_as_ref
    type:
      - 'null'
      - boolean
    doc: 'remove where all samples are same as reference'
    inputBinding:
      position: 101
      prefix: --remove-all-same-as-ref
  - id: remove_hom
    type:
      - 'null'
      - boolean
    doc: 'remove where sample is homozygous'
    inputBinding:
      position: 101
      prefix: --remove-hom
  - id: remove_same_as_ref
    type:
      - 'null'
      - boolean
    doc: 'remove where sample is same as reference'
    inputBinding:
      position: 101
      prefix: --remove-same-as-ref
  - id: snps_only
    type:
      - 'null'
      - boolean
    doc: 'only keep where sample variant is a simple SNP'
    inputBinding:
      position: 101
      prefix: --snps-only
  - id: clear_failed_samples
    type:
      - 'null'
      - boolean
    doc: 'retain failed records, set the sample GT field to missing'
    inputBinding:
      position: 101
      prefix: --clear-failed-samples
  - id: fail
    type:
      - 'null'
      - string
    doc: 'retain failed records, add the provided label to the FILTER field'
    inputBinding:
      position: 101
      prefix: --fail
  - id: fail_samples
    type:
      - 'null'
      - string
    doc: 'retain failed records, add the provided label to the sample FT field'
    inputBinding:
      position: 101
      prefix: --fail-samples
  - id: add_header
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --add-header
    doc: 'file containing VCF header lines to add, or a literal header line. May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: 'do not gzip the output'
    inputBinding:
      position: 101
      prefix: --no-gzip
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: 'prevent VCF header from being written'
    inputBinding:
      position: 101
      prefix: --no-header
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: 'Filtered VCF and its index'
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_vcffilter.out
