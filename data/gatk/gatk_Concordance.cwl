cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- Concordance
label: gatk_Concordance
doc: |-
  This tool evaluates an input VCF against a VCF that has been validated and is considered to represent ground truth. The summary statistics (# true positives, # false positives, # false negatives, sensitivity, precision) are reported in a TSV file (--summary). Note that this tool assumes that the truth VCF only contains PASS variants.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
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
- id: summary
  type: string
  doc: A table of summary statistics (true positives, sensitivity, etc.)
  inputBinding:
    prefix: --summary
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
- id: filter_analysis
  type:
  - 'null'
  - string
  doc: A table of the contribution of each filter to true and false negatives
  inputBinding:
    prefix: --filter-analysis
- id: filtered_true_negatives_and_false_negatives
  type:
  - 'null'
  - string
  doc: A vcf to write filtered true negatives and false negatives
  inputBinding:
    prefix: --filtered-true-negatives-and-false-negatives
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
- id: true_positives_and_false_negatives
  type:
  - 'null'
  - string
  doc: A vcf to write true positives and false negatives
  inputBinding:
    prefix: --true-positives-and-false-negatives
- id: true_positives_and_false_positives
  type:
  - 'null'
  - string
  doc: A vcf to write true positives and false positives
  inputBinding:
    prefix: --true-positives-and-false-positives
outputs:
- id: output_summary
  type: File
  doc: A table of summary statistics (true positives, sensitivity, etc.)
  outputBinding:
    glob: $(inputs.summary)
- id: output_filter_analysis
  type:
  - 'null'
  - File
  doc: A table of the contribution of each filter to true and false negatives
  outputBinding:
    glob: $(inputs.filter_analysis)
- id: output_filtered_true_negatives_and_false_negatives
  type:
  - 'null'
  - File
  doc: A vcf to write filtered true negatives and false negatives
  outputBinding:
    glob: $(inputs.filtered_true_negatives_and_false_negatives)
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: output_true_positives_and_false_negatives
  type:
  - 'null'
  - File
  doc: A vcf to write true positives and false negatives
  outputBinding:
    glob: $(inputs.true_positives_and_false_negatives)
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: output_true_positives_and_false_positives
  type:
  - 'null'
  - File
  doc: A vcf to write true positives and false positives
  outputBinding:
    glob: $(inputs.true_positives_and_false_positives)
  secondaryFiles:
  - pattern: .idx
    required: false
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
