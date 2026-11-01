cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- RemoveNearbyIndels
label: gatk_RemoveNearbyIndels
doc: |-
  Remove indels that are close to each other from a vcf. For any pair of indels that are withinsome minimum allowed distance, both indels are removed, regardless of any intervening non-indel variants.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: output
  type: string
  doc: The output filtered VCF file
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
- id: min_indel_spacing
  type:
  - 'null'
  - int
  doc: Minimum spacing between neighboring indels to be emitted
  inputBinding:
    position: 1
    prefix: --min-indel-spacing
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
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
    Must be a .dict file.
  inputBinding:
    position: 1
    prefix: --sequence-dictionary
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
  doc: The output filtered VCF file
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
