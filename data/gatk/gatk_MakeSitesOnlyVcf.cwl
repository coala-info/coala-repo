cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- MakeSitesOnlyVcf
label: gatk_MakeSitesOnlyVcf
doc: |-
  This tool reads a VCF/VCF.gz/BCF and removes all genotype information from it while retainingall site level information, including annotations based on genotypes (e.g. AN, AF). Output can beany supported variant format including .vcf, .vcf.gz or .bcf. Usage example: java -jar picard.jar MakeSitesOnlyVcf \ INPUT=input_variants.vcf \ OUTPUT=output_variants.vcf

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type: File
  doc: Input VCF or BCF containing genotype and site-level information.
  inputBinding:
    position: 1
    prefix: --INPUT
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: output
  type: string
  doc: Output VCF or BCF file containing only site-level information.
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
- id: sample
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --SAMPLE
  doc: Names of one or more samples to include in the output VCF.
  inputBinding:
    position: 1
outputs:
- id: output_file
  type: File
  doc: Output VCF or BCF file containing only site-level information.
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
