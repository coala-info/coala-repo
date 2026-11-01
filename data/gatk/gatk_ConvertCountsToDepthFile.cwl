cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - ConvertCountsToDepthFile
label: gatk_ConvertCountsToDepthFile
doc: |-
  Converts a counts file (*.counts.tsv) to a depth file (*.rd.txt).

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: counts_filename
    type: File
    inputBinding:
      position: 101
      prefix: --counts-filename
    doc: Input file of counts (*.counts.tsv).
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
  - id: output
    type: string
    inputBinding:
      position: 101
      prefix: --output
    doc: Output file of depth (*.rd.txt).
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
  - id: sample_name
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --sample-name
    doc: Sample label of the input file. If not provided, this tool extracts it from
      the input file header, and will throw an error if the header do not contain
      a sample name.
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
  - id: output_output
    type: File
    doc: Output file of depth (*.rd.txt).
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
