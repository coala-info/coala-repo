cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - FixMateInformation
label: gatk_FixMateInformation
doc: 'Verify mate-pair information between mates and fix if needed.This tool ensures that all mate-pair
  information is in sync between each read and its mate pair. If no OUTPUT file is supplied then the output
  is written to a temporary file and then copied over the INPUT file (with the original placed in a .old
  file.) Reads marked with the secondary alignment flag are written to the output file unchanged. However
  supplementary reads are corrected so that they point to the primary, non-supplemental mate record.


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --INPUT
    doc: The SAM/BAM/CRAM input files to check and fix. Multiple files will be merged and sorted. This
      argument must be specified at least once.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
    inputBinding:
      position: 101
  - id: add_mate_cigar
    type:
      - 'null'
      - boolean
    doc: 'Adds the mate CIGAR tag (MC) if true, does not if false. Default value: true. Possible values:
      {true, false}'
    inputBinding:
      position: 101
      prefix: --ADD_MATE_CIGAR
      valueFrom: $(String(self))
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: 'If true, assume that the input file is queryname sorted, even if the header says otherwise.
      Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
      valueFrom: $(String(self))
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: 'Whether to create an index when writing VCF or coordinate sorted BAM output. Default value:
      false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --CREATE_INDEX
      valueFrom: $(String(self))
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: 'Whether to create an MD5 digest for any BAM or FASTQ files created. Default value: false. Possible
      values: {true, false}'
    inputBinding:
      position: 101
      prefix: --CREATE_MD5_FILE
      valueFrom: $(String(self))
  - id: ignore_missing_mates
    type:
      - 'null'
      - boolean
    doc: 'If true, ignore missing mates, otherwise will throw an exception when missing mates are found.
      Default value: true. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --IGNORE_MISSING_MATES
      valueFrom: $(String(self))
  - id: output
    type:
      - 'null'
      - string
    doc: The output file to write to. If no output file is supplied, the input file is overwritten (only
      available with single input file).
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    secondaryFiles:
      - .fai
      - ^.dict
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'Optional sort order if the OUTPUT file should be sorted differently than the INPUT file. Possible
      values: {unsorted, queryname, coordinate, duplicate, unknown}'
    inputBinding:
      position: 101
      prefix: --SORT_ORDER
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Setting stringency to SILENT can
      improve performance when processing a BAM file in which variable-length data (read, qualities, tags)
      do not otherwise need to be decoded. Default value: STRICT. Possible values: {STRICT, LENIENT, SILENT}'
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: 'The output file to write to. If no output file is supplied, the input file is overwritten (only
      available with single input file). Default value: null.'
    outputBinding:
      glob: $(inputs.output)
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
      - pattern: .md5
        required: false
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
