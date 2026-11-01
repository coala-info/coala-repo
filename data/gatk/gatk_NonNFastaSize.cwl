cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- NonNFastaSize
label: gatk_NonNFastaSize
doc: |-
  Counts the number of non-N bases in a fasta file.This tool takes any FASTA-formatted file and counts the number of non-N bases in it.Note that it requires that the fasta file have associated index (.fai) and dictionary (.dict) files. Usage example: java -jar picard.jar NonNFastaSize \ I=input_sequence.fasta \ O=count.txt

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type: File
  doc: The input FASTA file.
  inputBinding:
    position: 1
    prefix: --INPUT
  secondaryFiles:
  - .fai
  - ^.dict
- id: output
  type: string
  doc: The output file in which to record the count.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: intervals
  type:
  - 'null'
  - File
  doc: An interval list file that contains the locations of the positions to assess.
    If not provided, the entire reference will be used
  inputBinding:
    position: 1
    prefix: --INTERVALS
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
  doc: The output file in which to record the count.
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
