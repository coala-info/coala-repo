cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- SortGff
label: gatk_SortGff
doc: |-
  Summary This tool sorts a gff3 file by coordinates, so that it can be indexed. It additionally adds flush directives where possible, which can significantly reduce the memory footprint of downstream tools. Sorting of multiple contigs can be specified by a sequence dictionary; if no sequence dictionary is specified, contigs are sorted lexicographically. Usage Examples 1. Sort gff3 file, add flush directives. Contigs will be sorted lexicographically. java -jar picard.jar SortGff I=input.gff3 O=output.gff3 2. Sort gff3 file, add flush directives. Contigs will be sorted according to order of sequence dictionary java -jar picard.jar SortGff I=input.gff3 O=output.gff3 SD=dictionary.dict

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type: File
  doc: Input Gff3 file to sort.
  inputBinding:
    prefix: --INPUT
- id: output
  type: string
  doc: Sorted Gff3 output file.
  inputBinding:
    prefix: --OUTPUT
- id: create_index
  type:
  - 'null'
  - boolean
  doc: 'Whether to create an index when writing VCF or coordinate sorted BAM output.
    Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --CREATE_INDEX
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: n_records_in_memory
  type:
  - 'null'
  - int
  doc: 'Number of records to hold in memory before spilling to disk Default value:
    50000.'
  inputBinding:
    prefix: --nRecordsInMemory
- id: reference_sequence
  type:
  - 'null'
  - File
  doc: Reference sequence file.
  inputBinding:
    prefix: --REFERENCE_SEQUENCE
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Dictionary to sort contigs by. If dictionary is not provided, contigs are sorted
    lexicographically.
  inputBinding:
    prefix: --SEQUENCE_DICTIONARY
outputs:
- id: output_output
  type: File
  doc: Sorted Gff3 output file.
  outputBinding:
    glob: $(inputs.output)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
