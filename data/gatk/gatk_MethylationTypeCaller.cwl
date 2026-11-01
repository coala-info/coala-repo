cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - MethylationTypeCaller
label: gatk_MethylationTypeCaller
doc: |-
  Tool that prints methylation-based coverage from supplied bisulfite sequenced, methylation-aware aligned BAM to the specified output vcf file

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --input
    inputBinding:
      position: 101
    doc: BAM/SAM/CRAM file containing reads This argument must be specified at least
      once.
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
  - id: output
    type: string
    inputBinding:
      position: 101
      prefix: --output
    doc: Output VCF file
  - id: reference
    type: File
    inputBinding:
      position: 101
      prefix: --reference
    doc: Reference sequence file
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
      - pattern: .gzi
        required: false
      - pattern: ^^.dict
        required: false
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
  - id: max_depth_per_sample
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-depth-per-sample
    doc: 'Maximum number of reads to retain per sample per locus. Reads above this
      threshold will be downsampled. Set to 0 to disable. Default value: 0.'
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
    doc: Output VCF file
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
