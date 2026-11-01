cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- ValidateBasicSomaticShortMutations
label: gatk_ValidateBasicSomaticShortMutations
doc: |-
  Check variants in a VCF against tumor-normal bams representing the same samples, though not the ones from the actual calls. Bare-bones implementation heavily inspired by MutationValidator from Broad CGA group. The algorithm is not the same. This tool can only handle exactly one validation PAIR at a time and this should not be RNA. Multiallelics in a VCF are not supported and will be skipped. This tool will validate germline mutations as true positives.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: discovery_sample_name
  type: string
  doc: sample name for discovery in VCF.
  inputBinding:
    prefix: --discovery-sample-name
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --input
  doc: BAM/SAM/CRAM file containing reads This argument must be specified at least
    once.
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.crai
    required: false
- id: output
  type: string
  doc: The output file, which will be a validation table (tsv).
  inputBinding:
    prefix: --output
- id: reference
  type: File
  doc: Reference sequence file
  inputBinding:
    prefix: --reference
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
- id: val_case_sample_name
  type: string
  doc: validation case sample name (in the bam)
  inputBinding:
    prefix: --val-case-sample-name
- id: val_control_sample_name
  type: string
  doc: validation control sample name (in the bam)
  inputBinding:
    prefix: --val-control-sample-name
- id: variant
  type: File
  doc: A VCF file containing variants
  inputBinding:
    prefix: --variant
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: annotated_vcf
  type:
  - 'null'
  - string
  doc: Optional output vcf containing original variants annotated with validation
    info.
  inputBinding:
    prefix: --annotated-vcf
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
- id: max_validation_normal_count
  type:
  - 'null'
  - int
  doc: 'Maximum read count in the validation normal for a variant to validate. More
    counts is considered an artifact. Default value: 1.'
  inputBinding:
    prefix: --max-validation-normal-count
- id: min_base_quality_cutoff
  type:
  - 'null'
  - int
  doc: 'minimum base quality to count a read toward validation. Default value: 20.'
  inputBinding:
    prefix: --min-base-quality-cutoff
- id: min_power
  type:
  - 'null'
  - double
  doc: 'Minimum power for an unvalidated variant to be considered a false positive.
    Default value: 0.9.'
  inputBinding:
    prefix: --min-power
- id: summary
  type:
  - 'null'
  - string
  doc: A table of summary statistics (true positives, sensitivity, etc.)
  inputBinding:
    prefix: --summary
outputs:
- id: output_output
  type: File
  doc: The output file, which will be a validation table (tsv).
  outputBinding:
    glob: $(inputs.output)
- id: output_annotated_vcf
  type:
  - 'null'
  - File
  doc: Optional output vcf containing original variants annotated with validation
    info.
  outputBinding:
    glob: $(inputs.annotated_vcf)
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: output_summary
  type:
  - 'null'
  - File
  doc: A table of summary statistics (true positives, sensitivity, etc.)
  outputBinding:
    glob: $(inputs.summary)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
