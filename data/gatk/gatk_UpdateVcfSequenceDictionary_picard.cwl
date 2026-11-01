cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- UpdateVcfSequenceDictionary
label: gatk_UpdateVcfSequenceDictionary_picard
doc: |-
  Takes a VCF and a second file that contains a sequence dictionary and updates the VCF with the new sequence dictionary.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type: File
  doc: Input VCF
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
  doc: Output VCF to be written.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: sequence_dictionary
  type: File
  doc: A Sequence Dictionary (can be read from one of the following file types (SAM,
    BAM, VCF, BCF, Interval List, Fasta, or Dict)
  inputBinding:
    position: 1
    prefix: --SEQUENCE_DICTIONARY
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
  doc: Output VCF to be written.
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
