cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - SamToFastq
label: picard_SamToFastq
doc: "Converts a SAM/BAM/CRAM file to FASTQ. Extracts read sequences and qualities
  from the input SAM/BAM/CRAM file and writes them into the output file in Sanger
  FASTQ format.\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs:
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: clipping_action
    type:
      - 'null'
      - string
    doc: "The action that should be taken with clipped reads: 'X' means the reads
      and qualities should be trimmed at the clipped position; 'N' means the bases
      should be changed to Ns in the clipped region; and any integer means that the
      base qualities should be set to that value in the clipped region."
    inputBinding:
      position: 101
      prefix: --CLIPPING_ACTION
  - id: clipping_attribute
    type:
      - 'null'
      - string
    doc: The attribute that stores the position at which the SAM record should 
      be clipped
    inputBinding:
      position: 101
      prefix: --CLIPPING_ATTRIBUTE
  - id: clipping_min_length
    type:
      - 'null'
      - int
    doc: When performing clipping with the CLIPPING_ATTRIBUTE and 
      CLIPPING_ACTION parameters, ensure that the resulting reads after clipping
      are at least CLIPPING_MIN_LENGTH bases long.
    default: 0
    inputBinding:
      position: 101
      prefix: --CLIPPING_MIN_LENGTH
  - id: compress_outputs_per_rg
    type:
      - 'null'
      - boolean
    doc: Compress output FASTQ files per read group using gzip and append a .gz 
      extension to the file names.
    default: false
    inputBinding:
      position: 101
      prefix: --COMPRESS_OUTPUTS_PER_RG
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created (e.g. BAM and VCF).
    default: 5
    inputBinding:
      position: 101
      prefix: --COMPRESSION_LEVEL
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: Whether to create an index when writing VCF or coordinate sorted BAM 
      output.
    default: false
    inputBinding:
      position: 101
      prefix: --CREATE_INDEX
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
    default: false
    inputBinding:
      position: 101
      prefix: --CREATE_MD5_FILE
  - id: include_non_pf_reads
    type:
      - 'null'
      - boolean
    doc: Include non-PF reads from the SAM file into the output FASTQ files.
    default: false
    inputBinding:
      position: 101
      prefix: --INCLUDE_NON_PF_READS
  - id: include_non_primary_alignments
    type:
      - 'null'
      - boolean
    doc: If true, include non-primary alignments in the output.
    default: false
    inputBinding:
      position: 101
      prefix: --INCLUDE_NON_PRIMARY_ALIGNMENTS
  - id: input
    type: File
    doc: Input SAM/BAM/CRAM file to extract reads from
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: interleave
    type:
      - 'null'
      - boolean
    doc: Will generate an interleaved fastq if paired, each line will have /1 or
      /2 to describe which end it came from
    default: false
    inputBinding:
      position: 101
      prefix: --INTERLEAVE
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    default: 500000
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: output_per_rg
    type:
      - 'null'
      - boolean
    doc: Output a FASTQ file per read group (two FASTQ files per read group if 
      the group is paired).
    default: false
    inputBinding:
      position: 101
      prefix: --OUTPUT_PER_RG
  - id: quality
    type:
      - 'null'
      - int
    doc: End-trim reads using the phred/bwa quality trimming algorithm and this 
      quality.
    inputBinding:
      position: 101
      prefix: --QUALITY
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: re_reverse
    type:
      - 'null'
      - boolean
    doc: Re-reverse bases and qualities of reads with negative strand flag set 
      before writing them to FASTQ
    default: true
    inputBinding:
      position: 101
      prefix: --RE_REVERSE
  - id: read1_max_bases_to_write
    type:
      - 'null'
      - int
    doc: The maximum number of bases to write from read 1 after trimming.
    inputBinding:
      position: 101
      prefix: --READ1_MAX_BASES_TO_WRITE
  - id: read1_trim
    type:
      - 'null'
      - int
    doc: The number of bases to trim from the beginning of read 1.
    default: 0
    inputBinding:
      position: 101
      prefix: --READ1_TRIM
  - id: read2_max_bases_to_write
    type:
      - 'null'
      - int
    doc: The maximum number of bases to write from read 2 after trimming.
    inputBinding:
      position: 101
      prefix: --READ2_MAX_BASES_TO_WRITE
  - id: read2_trim
    type:
      - 'null'
      - int
    doc: The number of bases to trim from the beginning of read 2.
    default: 0
    inputBinding:
      position: 101
      prefix: --READ2_TRIM
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: rg_tag
    type:
      - 'null'
      - string
    doc: The read group tag (PU or ID) to be used to output a FASTQ file per 
      read group.
    default: PU
    inputBinding:
      position: 101
      prefix: --RG_TAG
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    default: false
    inputBinding:
      position: 101
      prefix: --showHidden
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
    default: false
    inputBinding:
      position: 101
      prefix: --USE_JDK_DEFLATER
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Inflater instead of the Intel Inflater for reading 
      compressed input
    default: false
    inputBinding:
      position: 101
      prefix: --USE_JDK_INFLATER
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Possible values:
      {STRICT, LENIENT, SILENT}'
    default: STRICT
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: verbosity
    type:
      - 'null'
      - string
    doc: 'Control verbosity of logging. Possible values: {ERROR, WARNING, INFO, DEBUG}'
    default: INFO
    inputBinding:
      position: 101
      prefix: --VERBOSITY
outputs:
  - id: fastq
    type: File
    doc: Output FASTQ file (single-end fastq or, if paired, first end of the 
      pair FASTQ).
    outputBinding:
      glob: $(inputs.fastq)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory in which to output the FASTQ file(s). Used only when 
      OUTPUT_PER_RG is true.
    outputBinding:
      glob: $(inputs.output_dir)
  - id: second_end_fastq
    type:
      - 'null'
      - File
    doc: Output FASTQ file (if paired, second end of the pair FASTQ).
    outputBinding:
      glob: $(inputs.second_end_fastq)
  - id: unpaired_fastq
    type:
      - 'null'
      - File
    doc: Output FASTQ file for unpaired reads; may only be provided in 
      paired-FASTQ mode
    outputBinding:
      glob: $(inputs.unpaired_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
