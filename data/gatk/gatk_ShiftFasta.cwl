cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- ShiftFasta
label: gatk_ShiftFasta
doc: |-
  Create a new fasta starting at the shift-offset +1 position and a shift_back chain file that can be used with the Liftover tool. It will shift all contigs by default.

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
- id: shift_back_output
  type: string
  doc: Path to write the shift_back file to
  inputBinding:
    position: 1
    prefix: --shift-back-output
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
- id: interval_file_name
  type:
  - 'null'
  - string
  doc: Base name for interval files. Intervals will be midway between beginning and
    computed offset. If not specified, no interval files will be written.
  inputBinding:
    position: 1
    prefix: --interval-file-name
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
- id: shift_offset_list
  type:
  - 'null'
  - type: array
    items: int
    inputBinding:
      prefix: --shift-offset-list
  doc: Number of bases to skip in the reference before starting the shifted reference.
    If the reference contains multiple contigs, a value should be specified for each
    contig. For example, if 300 is specified, the new fasta will start at the 301th
    base (count starting at 1).If not specified, each contig will be shifted by half
    the number of bases. To skip the shifting of a contig, specify 0 in the list.
  inputBinding:
    position: 1
outputs:
- id: output_file
  type: File
  doc: Path to write the output fasta to
  outputBinding:
    glob: $(inputs.output)
- id: shift_back_output_file
  type: File
  doc: Path to write the shift_back file to
  outputBinding:
    glob: $(inputs.shift_back_output)
- id: interval_file_name_file
  type:
  - 'null'
  - File
  doc: Base name for interval files. Intervals will be midway between beginning and
    computed offset. If not specified, no interval files will be written.
  outputBinding:
    glob: $(inputs.interval_file_name)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
