cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - FastqToSam
label: gatk_FastqToSam
doc: 'Converts a FASTQ file to an unaligned BAM or SAM file. Output read records will contain the original
  base calls and quality scores will be translated depending on the base quality score encoding: FastqSanger,
  FastqSolexa and FastqIllumina. There are also arguments to provide values for SAM header and read attributes
  that are not present in FASTQ (e.g see RG or SM below).


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: fastq
    type: File
    doc: Input fastq file (optionally gzipped) for single end data, or first read in paired end data.
    inputBinding:
      position: 101
      prefix: --FASTQ
  - id: output
    type: string
    doc: Output BAM/SAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: sample_name
    type: string
    doc: Sample name to insert into the read group header
    inputBinding:
      position: 101
      prefix: --SAMPLE_NAME
  - id: allow_and_ignore_empty_lines
    type:
      - 'null'
      - boolean
    doc: 'Allow (and ignore) empty lines Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --ALLOW_AND_IGNORE_EMPTY_LINES
      valueFrom: $(String(self))
  - id: allow_empty_fastq
    type:
      - 'null'
      - boolean
    doc: 'Allow empty input fastq Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --ALLOW_EMPTY_FASTQ
      valueFrom: $(String(self))
  - id: comment
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --COMMENT
    doc: Comment(s) to include in the merged output file's header. This argument may be specified 0 or
      more times.
    inputBinding:
      position: 101
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
  - id: description
    type:
      - 'null'
      - string
    doc: Inserted into the read group header
    inputBinding:
      position: 101
      prefix: --DESCRIPTION
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Input fastq file (optionally gzipped) for the second read of paired end data.
    inputBinding:
      position: 101
      prefix: --FASTQ2
  - id: library_name
    type:
      - 'null'
      - string
    doc: The library name to place into the LB attribute in the read group header
    inputBinding:
      position: 101
      prefix: --LIBRARY_NAME
  - id: max_q
    type:
      - 'null'
      - int
    doc: 'Maximum quality allowed in the input fastq. An exception will be thrown if a quality is greater
      than this value. Default value: 93.'
    inputBinding:
      position: 101
      prefix: --MAX_Q
  - id: min_q
    type:
      - 'null'
      - int
    doc: 'Minimum quality allowed in the input fastq. An exception will be thrown if a quality is less
      than this value. Default value: 0.'
    inputBinding:
      position: 101
      prefix: --MIN_Q
  - id: platform
    type:
      - 'null'
      - string
    doc: The platform type (e.g. ILLUMINA, SOLID) to insert into the read group header
    inputBinding:
      position: 101
      prefix: --PLATFORM
  - id: platform_model
    type:
      - 'null'
      - string
    doc: Platform model to insert into the group header (free-form text providing further details of the
      platform/technology used)
    inputBinding:
      position: 101
      prefix: --PLATFORM_MODEL
  - id: platform_unit
    type:
      - 'null'
      - string
    doc: The platform unit (often run_barcode.lane) to insert into the read group header
    inputBinding:
      position: 101
      prefix: --PLATFORM_UNIT
  - id: predicted_insert_size
    type:
      - 'null'
      - int
    doc: Predicted median insert size, to insert into the read group header
    inputBinding:
      position: 101
      prefix: --PREDICTED_INSERT_SIZE
  - id: program_group
    type:
      - 'null'
      - string
    doc: Program group to insert into the read group header.
    inputBinding:
      position: 101
      prefix: --PROGRAM_GROUP
  - id: quality_format
    type:
      - 'null'
      - string
    doc: 'A value describing how the quality values are encoded in the input FASTQ file. Either Solexa
      (phred scaling + 66), Illumina (phred scaling + 64) or Standard (phred scaling + 33). If input is
      from a regular file and this value is not specified, the quality format will be detected automatically.
      If input is not from a regular file, this value is required. Possible values: {Solexa, Illumina,
      Standard}'
    inputBinding:
      position: 101
      prefix: --QUALITY_FORMAT
  - id: read_group_name
    type:
      - 'null'
      - string
    doc: 'Read group name Default value: A.'
    inputBinding:
      position: 101
      prefix: --READ_GROUP_NAME
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
  - id: run_date
    type:
      - 'null'
      - string
    doc: Date the run was produced, to insert into the read group header
    inputBinding:
      position: 101
      prefix: --RUN_DATE
  - id: sequencing_center
    type:
      - 'null'
      - string
    doc: The sequencing center from which the data originated
    inputBinding:
      position: 101
      prefix: --SEQUENCING_CENTER
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'The sort order for the output BAM/SAM/CRAM file. Default value: queryname. Possible values:
      {unsorted, queryname, coordinate, duplicate, unknown}'
    inputBinding:
      position: 101
      prefix: --SORT_ORDER
  - id: strip_unpaired_mate_number
    type:
      - 'null'
      - boolean
    doc: 'Deprecated (No longer used). If true and this is an unpaired fastq any occurrence of ''/1''
      or ''/2'' will be removed from the end of a read name. Default value: false. Possible values: {true,
      false}'
    inputBinding:
      position: 101
      prefix: --STRIP_UNPAIRED_MATE_NUMBER
      valueFrom: $(String(self))
  - id: use_sequential_fastqs
    type:
      - 'null'
      - boolean
    doc: 'Use sequential fastq files with the suffix <prefix>_###.fastq[.gz]. The files should be named:
      <prefix>_001.<extension>, <prefix>_002.<extension>, ..., <prefix>_XYZ.<extension> Use the *first*
      file for the --FASTQ argument, e.g., --FASTQ <prefix>_001.<extension>. If paired end, use the *first*
      read2 file for the --FASTQ2 argument, e.g., <R2_prefix>_001.<extension>. Example: combine and convert
      4 single end fastqs with filenames: RUNNAME_S8_L005_R1_001.fastq RUNNAME_S8_L005_R1_002.fastq RUNNAME_S8_L005_R1_003.fastq
      RUNNAME_S8_L005_R1_004.fastq Run command with --FASTQ RUNNAME_S8_L005_R1_001.fastq --USE_SEQUENTIAL_FASTQS
      true Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --USE_SEQUENTIAL_FASTQS
      valueFrom: $(String(self))
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
    type: File
    doc: Output BAM/SAM/CRAM file.
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
