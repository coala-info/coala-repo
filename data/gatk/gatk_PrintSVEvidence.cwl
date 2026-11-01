cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - PrintSVEvidence
label: gatk_PrintSVEvidence
doc: |-
  Merges multiple sources of SV evidence records of some particular feature type into a single output file.  Inputs must be locus-sorted.  Can also subset by regions or samples.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: evidence_file
    type:
      type: array
      items: File
      inputBinding:
        prefix: --evidence-file
    inputBinding:
      position: 101
    doc: Input feature file URI(s) with extension '.sr.txt', '.pe.txt', '.sd.txt',
      '.baf.txt', or '.rd.txt' (may be gzipped). Can also handle bci rather than txt
      files. This argument must be specified at least once.
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
    doc: Output file for features of a type matching the input. Will be indexed if
      it has a block-compressed extension (e.g. '.gz' or '.bci').
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
  - id: sample_names
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --sample-names
    inputBinding:
      position: 101
    doc: List of sample names to extract from the sources (either as a .list file
      or as repeated arguments). If not specified, all samples will be merged. This
      argument may be specified 0 or more times.
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
    doc: Output file for features of a type matching the input. Will be indexed if
      it has a block-compressed extension (e.g. '.gz' or '.bci').
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
