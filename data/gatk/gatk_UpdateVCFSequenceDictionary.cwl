cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- UpdateVCFSequenceDictionary
label: gatk_UpdateVCFSequenceDictionary
doc: |-
  Updates the sequence dictionary in a variant file using the dictionary from another variant, alignment, dictionary, or reference file. The dictionary must be valid for all variants in the target file.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: output
  type: string
  doc: File to which updated variants should be written
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
- id: replace
  type:
  - 'null'
  - boolean
  doc: 'Force replacement of the dictionary if the input file already has a dictionary
    Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --replace
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
    Must be a .dict file.
  inputBinding:
    position: 1
    prefix: --sequence-dictionary
- id: source_dictionary
  type:
  - 'null'
  - File
  doc: A variant, alignment, dictionary, or reference file to use as a dictionary
    source (optional if the sequence dictionary source is specified as a reference
    argument). The dictionary presented must be valid (contain a sequence record)
    for each sequence that is referenced by any variant in the input file.
  inputBinding:
    position: 1
    prefix: --source-dictionary
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
  doc: File to which updated variants should be written
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
