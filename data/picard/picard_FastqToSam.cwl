cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - FastqToSam
label: picard_FastqToSam
doc: 'Converts a FASTQ file to an unaligned BAM or SAM file. Output read records will
  contain the original base calls and quality scores will be translated depending
  on the base quality score encoding: FastqSanger, FastqSolexa and FastqIllumina.'
inputs:
  - id: fastq
    type: File
    doc: Input fastq file (optionally gzipped) for single end data, or first 
      read in paired end data.
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
    doc: Allow (and ignore) empty lines
    inputBinding:
      position: 101
      prefix: --ALLOW_AND_IGNORE_EMPTY_LINES
  - id: allow_empty_fastq
    type:
      - 'null'
      - boolean
    doc: Allow empty input fastq
    inputBinding:
      position: 101
      prefix: --ALLOW_EMPTY_FASTQ
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: comment
    type:
      - 'null'
      - type: array
        items: string
    doc: Comment(s) to include in the merged output file's header.
    inputBinding:
      position: 101
      prefix: --COMMENT
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created (e.g. BAM and VCF).
    inputBinding:
      position: 101
      prefix: --COMPRESSION_LEVEL
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: Whether to create an index when writing VCF or coordinate sorted BAM 
      output.
    inputBinding:
      position: 101
      prefix: --CREATE_INDEX
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
    inputBinding:
      position: 101
      prefix: --CREATE_MD5_FILE
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
    doc: Input fastq file (optionally gzipped) for the second read of paired end
      data.
    inputBinding:
      position: 101
      prefix: --FASTQ2
  - id: library_name
    type:
      - 'null'
      - string
    doc: The library name to place into the LB attribute in the read group 
      header
    inputBinding:
      position: 101
      prefix: --LIBRARY_NAME
  - id: max_q
    type:
      - 'null'
      - int
    doc: Maximum quality allowed in the input fastq.
    inputBinding:
      position: 101
      prefix: --MAX_Q
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: min_q
    type:
      - 'null'
      - int
    doc: Minimum quality allowed in the input fastq.
    inputBinding:
      position: 101
      prefix: --MIN_Q
  - id: platform
    type:
      - 'null'
      - string
    doc: The platform type (e.g. ILLUMINA, SOLID) to insert into the read group 
      header
    inputBinding:
      position: 101
      prefix: --PLATFORM
  - id: platform_model
    type:
      - 'null'
      - string
    doc: Platform model to insert into the group header
    inputBinding:
      position: 101
      prefix: --PLATFORM_MODEL
  - id: platform_unit
    type:
      - 'null'
      - string
    doc: The platform unit (often run_barcode.lane) to insert into the read 
      group header
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
    type: string
    doc: A value describing how the quality values are encoded in the input 
      FASTQ file (Solexa, Illumina, or Standard).
    inputBinding:
      position: 101
      prefix: --QUALITY_FORMAT
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: read_group_name
    type:
      - 'null'
      - string
    doc: Read group name
    inputBinding:
      position: 101
      prefix: --READ_GROUP_NAME
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
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
    doc: The sort order for the output BAM/SAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --SORT_ORDER
  - id: strip_unpaired_mate_number
    type:
      - 'null'
      - boolean
    doc: Deprecated (No longer used). If true and this is an unpaired fastq any 
      occurrence of '/1' or '/2' will be removed from the end of a read name.
    inputBinding:
      position: 101
      prefix: --STRIP_UNPAIRED_MATE_NUMBER
  - id: tmp_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: One or more directories with space available to be used by this program
      for temporary storage of working files
    inputBinding:
      position: 101
      prefix: --TMP_DIR
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Deflater instead of the Intel Deflater for writing 
      compressed output
    inputBinding:
      position: 101
      prefix: --USE_JDK_DEFLATER
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Inflater instead of the Intel Inflater for reading 
      compressed input
    inputBinding:
      position: 101
      prefix: --USE_JDK_INFLATER
  - id: use_sequential_fastqs
    type:
      - 'null'
      - boolean
    doc: Use sequential fastq files with the suffix <prefix>_###.fastq[.gz].
    inputBinding:
      position: 101
      prefix: --USE_SEQUENTIAL_FASTQS
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: Validation stringency for all SAM files read by this program.
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
outputs:
  - id: output_output
    type: File
    doc: Output BAM/SAM/CRAM file.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
