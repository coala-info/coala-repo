cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- ExtractSequences
label: gatk_ExtractSequences
doc: |-
  Subsets intervals from a reference sequence to a new FASTA file.This tool takes a list of intervals, reads the corresponding subsquences from a reference FASTA file and writes them to a new FASTA file as separate records. Note that the reference FASTA file must be accompanied by an index file and the interval list must be provided in Picard list format.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: interval_list
  type: File
  doc: Interval list describing intervals to be extracted from the reference sequence.
  inputBinding:
    position: 1
    prefix: --INTERVAL_LIST
- id: output
  type: string
  doc: Output FASTA file.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: reference_sequence
  type: File
  doc: Reference sequence file.
  inputBinding:
    position: 1
    prefix: --REFERENCE_SEQUENCE
  secondaryFiles:
  - .fai
  - ^.dict
- id: line_length
  type:
  - 'null'
  - int
  doc: Maximum line length for sequence data.
  inputBinding:
    position: 1
    prefix: --LINE_LENGTH
outputs:
- id: output_file
  type: File
  doc: Output FASTA file.
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
