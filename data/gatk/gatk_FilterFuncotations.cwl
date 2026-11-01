cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- FilterFuncotations
label: gatk_FilterFuncotations
doc: |-
  Filter variants based on clinically-significant Funcotations. This proof-of-concept tool is an example for how to parse and use the VCF output of Funcotator. Currently hard-coded to look for specific Funcotations from: * ClinVar (http://www.clinvar.com/) * Laboratory for Molecular Medicine (LMM) (http://personalizedmedicine.partners.org/laboratory-for-molecular-medicine/) Also looks for Funcotations from whichever of the following is specified by the user: * Exome Aggregation Consortium (ExAC) (http://exac.broadinstitute.org/) * Genome Aggregation Database (gnomAD) (http://gnomad.broadinstitute.org/)

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: allele_frequency_data_source
  type: string
  doc: 'The allele frequency data source (ExAC or gnomAD) that was used to Funcotate
    the input VCF. Possible values: {exac, gnomad}'
  inputBinding:
    prefix: --allele-frequency-data-source
- id: output
  type: string
  doc: Output VCF file to which filtered variants should be written.
  inputBinding:
    prefix: --output
- id: ref_version
  type: string
  doc: 'The version of the Human Genome reference which was used to Funcotate the
    input VCF. Possible values: {b37, hg19, hg38}'
  inputBinding:
    prefix: --ref-version
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
- id: output_output
  type: File
  doc: Output VCF file to which filtered variants should be written.
  outputBinding:
    glob: $(inputs.output)
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
