cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- MakeVcfSampleNameMap
label: gatk_MakeVcfSampleNameMap
doc: |-
  Creates a TSV from sample name to VCF/GVCF path, with one line per input. Input VCF/GVCFs must contain a header describing exactly one sample. Usage example: java -jar picard.jar MakeVcfSampleNameMap \ INPUT=sample1.vcf.gz \ INPUT=sample2.vcf.gz \ OUTPUT=cohort.sample_map

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --INPUT
  doc: One or more input VCFs to extract sample names from.
  inputBinding:
    position: 1
- id: output
  type: string
  doc: Output file to write the sample-name map to.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: reference_sequence
  type:
  - 'null'
  - File
  doc: Reference sequence file.
  inputBinding:
    position: 1
    prefix: --REFERENCE_SEQUENCE
  secondaryFiles:
  - .fai
  - ^.dict
outputs:
- id: output_file
  type: File
  doc: Output file to write the sample-name map to.
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
