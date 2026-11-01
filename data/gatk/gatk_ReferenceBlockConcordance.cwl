cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- ReferenceBlockConcordance
label: gatk_ReferenceBlockConcordance
doc: |-
  This tool evaluates two GVCF files against each other and produces three histograms: Truth block histogram: Indicates the number of occurrence of reference blocks with a given confidence score and length in the truth GVCF Eval block histogram: Indicates the number of occurrence of reference blocks with a given confidence score and length in the eval GVCF Confidence concordance histogram: Reflects the confidence scores of bases in reference blocks in the truth and eval VCF, respectively. An entry of 10 at bin "80,90" means that 10 bases in the truth GVCF have a confidence score of 80 while those same bases have a score of 90 in the eval GVCF. In contrast to the Concordance tool, this tool considers all variants, regardless of passing or failing filters.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: confidence_concordance_histogram
  type: string
  doc: Reflects the confidence scores of bases in reference blocks in the truth and
    eval VCF, respectively. An entry of 10 at bin "80,90" means that 10 bases in the
    truth GVCF have a confidence score of 80 while those same bases have a score of
    90 in the eval GVCF.
  inputBinding:
    prefix: --confidence-concordance-histogram
- id: eval_block_histogram
  type: string
  doc: A histogram of block lengths and their associated confidence scores for the
    eval sample
  inputBinding:
    prefix: --eval-block-histogram
- id: evaluation
  type: File
  doc: A VCF containing variants to be compared to the truth
  inputBinding:
    prefix: --evaluation
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: truth
  type: File
  doc: A VCF containing truth variants
  inputBinding:
    prefix: --truth
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: truth_block_histogram
  type: string
  doc: A histogram of block lengths and their associated confidence scores for the
    truth sample
  inputBinding:
    prefix: --truth-block-histogram
- id: confidence
  type:
  - 'null'
  - File
  doc: TO BE IMPLEMENTED
  inputBinding:
    prefix: --confidence
- id: exclude_intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --exclude-intervals
  doc: One or more genomic intervals to exclude from processing This argument may
    be specified 0 or more times.
- id: interval_padding
  type:
  - 'null'
  - int
  doc: 'Amount of padding (in bp) to add to each interval you are including. Default
    value: 0.'
  inputBinding:
    prefix: --interval-padding
- id: intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate This argument may be specified
    0 or more times.
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence
  inputBinding:
    prefix: --reference
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
outputs:
- id: output_confidence_concordance_histogram
  type: File
  doc: Reflects the confidence scores of bases in reference blocks in the truth and
    eval VCF, respectively. An entry of 10 at bin "80,90" means that 10 bases in the
    truth GVCF have a confidence score of 80 while those same bases have a score of
    90 in the eval GVCF.
  outputBinding:
    glob: $(inputs.confidence_concordance_histogram)
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: output_eval_block_histogram
  type: File
  doc: A histogram of block lengths and their associated confidence scores for the
    eval sample
  outputBinding:
    glob: $(inputs.eval_block_histogram)
- id: output_truth_block_histogram
  type: File
  doc: A histogram of block lengths and their associated confidence scores for the
    truth sample
  outputBinding:
    glob: $(inputs.truth_block_histogram)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
