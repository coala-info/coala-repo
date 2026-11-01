cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- GenotypeConcordance
label: gatk_GenotypeConcordance
doc: |-
  Calculates the concordance between genotype data of one sample in each of two VCFs - truth (or reference) vs. calls. Summary Calculates the concordance between genotype data of one sample in each of two VCFs - one being considered the truth (or reference) the other being the call. The concordance is broken into separate results sections for SNPs and indels. Summary and detailed statistics are reported. Details This tool evaluates the concordance between genotype calls for a sample in different callsets where one is being considered as the "truth" (aka standard, or reference) and the other as the "call" that is being evaluated for accuracy. The Comparison can be restricted to a confidence interval which is typically used in order to enable proper assessment of False Positives and the False-Positive Rate (FPR). Usage example Compare two VCFs within a confidence region java -jar picard.jar GenotypeConcordance \ CALL_VCF=input.vcf \ CALL_SAMPLE=sample_name \ O=gc_concordance.vcf \ TRUTH_VCF=truth_set.vcf \ TRUTH_SAMPLE=sample_in_truth \ INTERVALS=confident.interval_list \ MISSING_SITES_HOM_REF = true Output Metrics: Output metrics consists of GenotypeConcordanceContingencyMetrics, GenotypeConcordanceSummaryMetrics, and GenotypeConcordanceDetailMetrics. For each set of metrics, the data is broken into separate sections for SNPs and INDELs. Note that only SNP and INDEL variants are considered, MNP, Symbolic, and Mixed classes of variants are not included. - GenotypeConcordanceContingencyMetrics enumerate the constituents of each contingent in a callset including true-positive(TP), true-negative (TN), false-positive (FP), and false-negative (FN) calls. Seehttp://broadinstitute.github.io/picard/picard-metric-definitions.html#GenotypeConcordanceContingencyMetrics for more details. - GenotypeConcordanceDetailMetrics include the numbers of SNPs and INDELs for each contingent genotype as well as thenumber of validated genotypes. Seehttp://broadinstitute.github.io/picard/picard-metric-definitions.html#GenotypeConcordanceDetailMetrics for more details.- GenotypeConcordanceSummaryMetrics provide specific details for the variant caller performance on a callset including:values for sensitivity, specificity, and positive predictive values. Seehttp://broadinstitute.github.io/picard/picard-metric-definitions.html#GenotypeConcordanceSummaryMetrics for more details. Useful definitions applicable to alleles and genotypes: Truthset - A callset (typically in VCF format) containing variant calls and genotypes that have been cross-validatedwith multiple technologies e.g. Genome In A Bottle Consortium (GIAB) (https://sites.stanford.edu/abms/giab) TP - True-positives are variant sites that match against the truth-set FP - False-positives are reference sites miscalled as variant FN - False-negatives are variant sites miscalled as reference TN - True-negatives are correctly called as reference Validated genotypes - are TP sites where the exact genotype (HET or HOM-VAR) appears in the truth-set VCF Output: - The concordance state will be stored in the CONC_ST tag in the INFO field - The truth sample name will be "truth" and call sample name will be "call"

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: call_vcf
  type: File
  doc: The VCF containing the call sample
  inputBinding:
    prefix: --CALL_VCF
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: output
  type: string
  doc: Basename for the three metrics files that are to be written. Resulting files
    will be <OUTPUT>.genotype_concordance_summary_metrics, <OUTPUT>.genotype_concordance_detail_metrics,
    and <OUTPUT>.genotype_concordance_contingency_metrics.
  inputBinding:
    prefix: --OUTPUT
- id: truth_vcf
  type: File
  doc: The VCF containing the truth sample
  inputBinding:
    prefix: --TRUTH_VCF
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: call_sample
  type:
  - 'null'
  - string
  doc: The name of the call sample within the call VCF. Not required if only one sample
    exists.
  inputBinding:
    prefix: --CALL_SAMPLE
- id: create_index
  type:
  - 'null'
  - boolean
  doc: 'Whether to create an index when writing VCF or coordinate sorted BAM output.
    Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --CREATE_INDEX
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_filter_status
  type:
  - 'null'
  - boolean
  doc: 'Default is false. If true, filter status of sites will be ignored so that
    we include filtered sites when calculating genotype concordance. Default value:
    false. Possible values: {true, false}'
  inputBinding:
    prefix: --IGNORE_FILTER_STATUS
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: intersect_intervals
  type:
  - 'null'
  - boolean
  doc: 'If true, multiple interval lists will be intersected. If false multiple lists
    will be unioned. Default value: true. Possible values: {true, false}'
  inputBinding:
    prefix: --INTERSECT_INTERVALS
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: intervals
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --INTERVALS
  doc: One or more interval list files that will be used to limit the genotype concordance.
    Note - if intervals are specified, the VCF files must be indexed. This argument
    may be specified 0 or more times.
- id: min_dp
  type:
  - 'null'
  - int
  doc: 'Genotypes below this depth will have genotypes classified as LowDp. Default
    value: 0.'
  inputBinding:
    prefix: --MIN_DP
- id: min_gq
  type:
  - 'null'
  - int
  doc: 'Genotypes below this genotype quality will have genotypes classified as LowGq.
    Default value: 0.'
  inputBinding:
    prefix: --MIN_GQ
- id: missing_sites_hom_ref
  type:
  - 'null'
  - boolean
  doc: 'Default is false, which follows the GA4GH Scheme. If true, missing sites in
    the truth set will be treated as HOM_REF sites and sites missing in both the truth
    and call sets will be true negatives. Useful when hom ref sites are left out of
    the truth set. This flag can only be used with a high confidence interval list.
    Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --MISSING_SITES_HOM_REF
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: output_all_rows
  type:
  - 'null'
  - boolean
  doc: 'If true, output all rows in detailed statistics even when count == 0. When
    false only output rows with non-zero counts. Default value: false. Possible values:
    {true, false}'
  inputBinding:
    prefix: --OUTPUT_ALL_ROWS
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: output_vcf
  type:
  - 'null'
  - boolean
  doc: 'Output a VCF annotated with concordance information. Default value: false.
    Possible values: {true, false}'
  inputBinding:
    prefix: --OUTPUT_VCF
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: reference_sequence
  type:
  - 'null'
  - File
  doc: Reference sequence file.
  inputBinding:
    prefix: --REFERENCE_SEQUENCE
- id: truth_sample
  type:
  - 'null'
  - string
  doc: The name of the truth sample within the truth VCF. Not required if only one
    sample exists.
  inputBinding:
    prefix: --TRUTH_SAMPLE
- id: use_vcf_index
  type:
  - 'null'
  - boolean
  doc: 'If true, use the VCF index, else iterate over the entire VCF. Default value:
    false. Possible values: {true, false}'
  inputBinding:
    prefix: --USE_VCF_INDEX
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: summary_metrics
  type: File
  doc: Summary metrics (<OUTPUT>.genotype_concordance_summary_metrics)
  outputBinding:
    glob: $(inputs.output).genotype_concordance_summary_metrics
- id: detail_metrics
  type: File
  doc: Detail metrics (<OUTPUT>.genotype_concordance_detail_metrics)
  outputBinding:
    glob: $(inputs.output).genotype_concordance_detail_metrics
- id: contingency_metrics
  type: File
  doc: Contingency metrics (<OUTPUT>.genotype_concordance_contingency_metrics)
  outputBinding:
    glob: $(inputs.output).genotype_concordance_contingency_metrics
- id: concordance_vcf
  type:
  - 'null'
  - File
  doc: VCF annotated with concordance information (written when output_vcf is set)
  outputBinding:
    glob: $(inputs.output).genotype_concordance.vcf.gz
  secondaryFiles:
  - pattern: .tbi
    required: false
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
