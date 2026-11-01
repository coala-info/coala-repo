cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- LeftAlignAndTrimVariants
label: gatk_LeftAlignAndTrimVariants
doc: |-
  This tool takes a VCF file, left-aligns the indels and trims common bases from indels,leaving them with a minimum representation. The same indel can often be placed at multiple positions and stillrepresent the same haplotype. While the standard convention with VCF is to place an indel at the left-most positionthis isn't always done, so this tool can be used to left-align them.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: output
  type: string
  doc: File to which variants should be written
  inputBinding:
    position: 1
    prefix: --output
- id: reference
  type: File
  doc: Reference sequence file
  inputBinding:
    position: 1
    prefix: --reference
  secondaryFiles:
  - .fai
  - ^.dict
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
- id: dont_trim_alleles
  type:
  - 'null'
  - boolean
  doc: 'Do not Trim alleles to remove bases common to all of them Possible values:
    true, false.'
  inputBinding:
    position: 1
    prefix: --dont-trim-alleles
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
- id: max_indel_length
  type:
  - 'null'
  - int
  doc: Set maximum indel size to realign
  inputBinding:
    position: 1
    prefix: --max-indel-length
- id: max_leading_bases
  type:
  - 'null'
  - int
  doc: Set max reference window size to look back before allele
  inputBinding:
    position: 1
    prefix: --max-leading-bases
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
    Must be a .dict file.
  inputBinding:
    position: 1
    prefix: --sequence-dictionary
- id: split_multi_allelics
  type:
  - 'null'
  - boolean
  doc: 'Split multiallelic records and left-align individual alleles Possible values:
    true, false.'
  inputBinding:
    position: 1
    prefix: --split-multi-allelics
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
  doc: File to which variants should be written
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
