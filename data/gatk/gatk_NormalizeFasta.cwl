cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- NormalizeFasta
label: gatk_NormalizeFasta
doc: |-
  Normalizes lines of sequence in a FASTA file to be of the same length.This tool takes any FASTA-formatted file and reformats the sequence to ensure that all of the sequence record lines are of the same length (with the exception of the last line). Although the default setting is 100 bases per line, a custom line_length can be specified by the user.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type: File
  doc: The input FASTA file to normalize.
  inputBinding:
    position: 1
    prefix: --INPUT
- id: output
  type: string
  doc: The output FASTA file to write.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: line_length
  type:
  - 'null'
  - int
  doc: The line length to be used for the output FASTA file.
  inputBinding:
    position: 1
    prefix: --LINE_LENGTH
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
- id: truncate_sequence_names_at_whitespace
  type:
  - 'null'
  - boolean
  doc: 'Truncate sequence names at first whitespace. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --TRUNCATE_SEQUENCE_NAMES_AT_WHITESPACE
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: output_file
  type: File
  doc: The output FASTA file to write.
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
