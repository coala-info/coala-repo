cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- CompareReferences
label: gatk_CompareReferences
doc: |-
  Compare multiple references and output a tab-delimited table detailing what the differences are and a summarized analysis of each pair of references.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: reference
  type: File
  doc: Reference sequence file
  inputBinding:
    position: 1
    prefix: --reference
  secondaryFiles:
  - .fai
  - ^.dict
- id: references_to_compare
  type:
    type: array
    items: File
    inputBinding:
      prefix: --references-to-compare
  doc: Reference sequence file(s) to compare.
  inputBinding:
    position: 1
  secondaryFiles:
  - .fai
  - ^.dict
- id: base_comparison
  type:
  - 'null'
  - string
  doc: 'Mode for base-level comparisons. Default is off, but can do full alignment
    of mismatching sequences to find SNPs and INDELs (FULL_ALIGNMENT), or detect SNPs
    only in mismatching sequences of the same length (FIND_SNPS_ONLY). Possible values:
    NO_BASE_COMPARISON, FULL_ALIGNMENT, FIND_SNPS_ONLY.'
  inputBinding:
    position: 1
    prefix: --base-comparison
- id: base_comparison_output
  type:
  - 'null'
  - string
  doc: Output directory for base comparison outputs. Required for running base-comparison
    in FULL_ALIGNMENT or FIND_SNPS_ONLY mode.
  inputBinding:
    position: 1
    prefix: --base-comparison-output
- id: display_only_differing_sequences
  type:
  - 'null'
  - boolean
  doc: 'If provided, only display sequence names that differ in their actual sequence.
    Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --display-only-differing-sequences
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: display_sequences_by_name
  type:
  - 'null'
  - boolean
  doc: 'If provided, the table by sequence name will be printed. Possible values:
    true, false.'
  inputBinding:
    position: 1
    prefix: --display-sequences-by-name
    valueFrom: '$(self ? ''true'' : ''false'')'
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
- id: md5_calculation_mode
  type:
  - 'null'
  - string
  doc: 'MD5CalculationMode indicating method of MD5 calculation. Possible values:
    USE_DICT, RECALCULATE_IF_MISSING, ALWAYS_RECALCULATE.'
  inputBinding:
    position: 1
    prefix: --md5-calculation-mode
- id: output
  type:
  - 'null'
  - string
  default: compare.tsv
  doc: If specified, output reference sequence table in TSV format to this file. Otherwise
    print it to stdout.
  inputBinding:
    position: 1
    prefix: --output
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
    Must be a .dict file.
  inputBinding:
    position: 1
    prefix: --sequence-dictionary
outputs:
- id: base_comparison_output_file
  type:
  - 'null'
  - File
  doc: Output directory for base comparison outputs. Required for running base-comparison
    in FULL_ALIGNMENT or FIND_SNPS_ONLY mode.
  outputBinding:
    glob: $(inputs.base_comparison_output)
- id: output_file
  type: File
  doc: If specified, output reference sequence table in TSV format to this file. Otherwise
    print it to stdout.
  outputBinding:
    glob: $(inputs.output)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
