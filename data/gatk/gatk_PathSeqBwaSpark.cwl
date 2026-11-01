cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - PathSeqBwaSpark
label: gatk_PathSeqBwaSpark
doc: |-
  Align reads to a microbe reference using BWA-MEM and Spark. Second step in the PathSeq pipeline.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: microbe_bwa_image
    type: File
    inputBinding:
      position: 101
      prefix: --microbe-bwa-image
    doc: Microbe reference BWA index image file generated using BwaMemIndexImageCreator.
      If running on a Spark cluster, this must be distributed to local disk on each
      node.
  - id: microbe_dict
    type: File
    inputBinding:
      position: 101
      prefix: --microbe-dict
    doc: Use the given sequence dictionary as the microbe sequence dictionary. Must
      be a .dict file.
  - id: bwa_score_threshold
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --bwa-score-threshold
    doc: 'Minimum score threshold for microbe alignments Default value: 30.'
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
  - id: max_alternate_hits
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-alternate-hits
    doc: 'Maximum number of alternate microbe alignments Default value: 5000.'
  - id: microbe_min_seed_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --microbe-min-seed-length
    doc: 'Minimum BWA-MEM seed length for the microbe alignment Default value: 19.'
  - id: paired_input
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --paired-input
    doc: Input queryname-sorted BAM containing only paired reads
  - id: paired_output
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --paired-output
    doc: Output BAM containing only paired reads
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
  - id: unpaired_input
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --unpaired-input
    doc: Input BAM containing only unpaired reads
  - id: unpaired_output
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --unpaired-output
    doc: Output BAM containing only unpaired reads
outputs:
  - id: paired_output_out
    type:
      - 'null'
      - File
    doc: Output BAM containing only paired reads
    outputBinding:
      glob: $(inputs.paired_output)
  - id: unpaired_output_out
    type:
      - 'null'
      - File
    doc: Output BAM containing only unpaired reads
    outputBinding:
      glob: $(inputs.unpaired_output)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
