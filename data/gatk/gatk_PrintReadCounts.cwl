cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - PrintReadCounts
label: gatk_PrintReadCounts
doc: |-
  Prints count files for CNV determination.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: input_counts
    type: File
    inputBinding:
      position: 101
      prefix: --input-counts
    doc: Input file of counts
  - id: disable_sequence_dictionary_validation
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --disable-sequence-dictionary-validation
    doc: 'If specified, do not check the sequence dictionaries from our inputs for
      compatibility. Use at your own risk! Default value: false. Possible values:
      {true, false}'
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals to exclude from processing This argument may
      be specified 0 or more times.
  - id: input
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --input
    inputBinding:
      position: 101
    doc: BAM/SAM/CRAM file containing reads This argument may be specified 0 or more
      times.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
      - pattern: .sbi
        required: false
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals over which to operate This argument may be
      specified 0 or more times.
  - id: output_file_list
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --output-file-list
    doc: Two-column list of outputs in the form <sample-name>\t<output file path>
  - id: output_prefix
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --output-prefix
    doc: 'Output file path prefix. Paths have the form "{output-prefix}{sample-name}.counts.tsv".
      Default is the current working directory. Default value: .'
  - id: reference
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --reference
    doc: Reference sequence
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
      - pattern: .gzi
        required: false
      - pattern: ^^.dict
        required: false
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
    doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
      Must be a .dict file.
outputs:
  - id: output_file_list_out
    type:
      - 'null'
      - File
    doc: Two-column list of outputs in the form <sample-name>\t<output file path>
    outputBinding:
      glob: $(inputs.output_file_list)
  - id: output_prefix_out
    type:
      type: array
      items: File
    doc: 'Output file path prefix. Paths have the form "{output-prefix}{sample-name}.counts.tsv".
      Default is the current working directory. Default value: .'
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
