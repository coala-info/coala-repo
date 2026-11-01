cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- FastaAlternateReferenceMaker
label: gatk_FastaAlternateReferenceMaker
doc: |-
  Create an alternative fasta reference by inserting variants from a vcf into an existing reference sequence.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: output
  type: string
  doc: Path to write the output fasta to
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
  doc: A source of variants to merge with the reference sequence.
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
- id: line_width
  type:
  - 'null'
  - int
  doc: Maximum length of sequence to write per line
  inputBinding:
    position: 1
    prefix: --line-width
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
    Must be a .dict file.
  inputBinding:
    position: 1
    prefix: --sequence-dictionary
- id: snp_mask
  type:
  - 'null'
  - File
  doc: SNP mask VCF file
  inputBinding:
    position: 1
    prefix: --snp-mask
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: snp_mask_priority
  type:
  - 'null'
  - boolean
  doc: 'Give the snp mask priority over the input VCF. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --snp-mask-priority
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: use_iupac_sample
  type:
  - 'null'
  - string
  doc: If specified, heterozygous SNP sites will be output using IUPAC ambiguity codes
    given the genotypes for this sample
  inputBinding:
    position: 1
    prefix: --use-iupac-sample
outputs:
- id: output_file
  type: File
  doc: Path to write the output fasta to
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
