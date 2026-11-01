cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- SamToFastqWithTags
label: gatk_SamToFastqWithTags
doc: |-
  Converts a SAM or BAM file to FASTQ alongside FASTQs created from tags. Extracts read sequences and qualities from the input SAM/BAM file and SAM/BAM tags and writes them into the output file in Sanger FASTQ format. See MAQ FASTQ specification for details. The following example will create two FASTQs from tags. One will be converted with the base sequence coming from the "CR" tag and base quality from the "CY" tag. The other fastq will be converted with the base sequence coming from the "CB" and "UR" tags concatenated together with no separator (not specified on command line) with the base qualities coming from the "CY" and "UY" tags concatenated together. The two files will be named CR.fastq and CB_UR.fastq. java -jar picard.jar SamToFastqWithTags I=input.bam FASTQ=output.fastq SEQUENCE_TAG_GROUP=CR QUALITY_TAG_GROUP=CY SEQUENCE_TAG_GROUP="CB,UR" QUALITY_TAG_GROUP="CY,UY"

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: fastq
  type:
  - 'null'
  - string
  doc: Output FASTQ file (single-end fastq or, if paired, first end of the pair FASTQ). Cannot be used
    in conjunction with argument(s) OUTPUT_PER_RG (OPRG) COMPRESS_OUTPUTS_PER_RG (GZOPRG) OUTPUT_DIR (ODIR)
  inputBinding:
    position: 101
    prefix: --FASTQ
- id: input
  type: File
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: Input SAM/BAM/CRAM file to extract reads from
  inputBinding:
    position: 101
    prefix: --INPUT
- id: sequence_tag_group
  type:
    type: array
    items: string
    inputBinding:
      prefix: --SEQUENCE_TAG_GROUP
  doc: List of comma separated tag values to extract from Input SAM/BAM to be used as read sequence
  inputBinding:
    position: 101
- id: arguments_file
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --arguments_file
  doc: read one or more arguments files and add them to the command line
  inputBinding:
    position: 101
- id: clipping_action
  type:
  - 'null'
  - string
  doc: 'The action that should be taken with clipped reads: ''X'' means the reads and qualities should
    be trimmed at the clipped position; ''N'' means the bases should be changed to Ns in the clipped region;
    and any integer means that the base qualities should be set to that value in the clipped region.'
  inputBinding:
    position: 101
    prefix: --CLIPPING_ACTION
- id: clipping_attribute
  type:
  - 'null'
  - string
  doc: The attribute that stores the position at which the SAM record should be clipped
  inputBinding:
    position: 101
    prefix: --CLIPPING_ATTRIBUTE
- id: clipping_min_length
  type:
  - 'null'
  - int
  doc: When performing clipping with the CLIPPING_ATTRIBUTE and CLIPPING_ACTION parameters, ensure that
    the resulting reads after clipping are at least CLIPPING_MIN_LENGTH bases long. If the original read
    is shorter than CLIPPING_MIN_LENGTH then the original read length will be maintained.
  inputBinding:
    position: 101
    prefix: --CLIPPING_MIN_LENGTH
- id: compress_outputs_per_rg
  type:
  - 'null'
  - boolean
  doc: Compress output FASTQ files per read group using gzip and append a .gz extension to the file names.
  inputBinding:
    position: 101
    prefix: --COMPRESS_OUTPUTS_PER_RG
    valueFrom: '$(self === null ? null : String(self))'
- id: compress_outputs_per_tag_group
  type:
  - 'null'
  - boolean
  doc: Compress output FASTQ files per Tag grouping using gzip and append a .gz extension to the file
    names.
  inputBinding:
    position: 101
    prefix: --COMPRESS_OUTPUTS_PER_TAG_GROUP
    valueFrom: '$(self === null ? null : String(self))'
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
  doc: Whether to create an index when writing VCF or coordinate sorted BAM output.
  inputBinding:
    position: 101
    prefix: --CREATE_INDEX
    valueFrom: '$(self === null ? null : String(self))'
- id: create_md5_file
  type:
  - 'null'
  - boolean
  doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
  inputBinding:
    position: 101
    prefix: --CREATE_MD5_FILE
    valueFrom: '$(self === null ? null : String(self))'
- id: include_non_pf_reads
  type:
  - 'null'
  - boolean
  doc: Include non-PF reads from the SAM file into the output FASTQ files. PF means 'passes filtering'.
    Reads whose 'not passing quality controls' flag is set are non-PF reads. See GATK Dictionary for more
    info.
  inputBinding:
    position: 101
    prefix: --INCLUDE_NON_PF_READS
    valueFrom: '$(self === null ? null : String(self))'
- id: include_non_primary_alignments
  type:
  - 'null'
  - boolean
  doc: If true, include non-primary alignments in the output. Support of non-primary alignments in SamToFastq
    is not comprehensive, so there may be exceptions if this is set to true and there are paired reads
    with non-primary alignments.
  inputBinding:
    position: 101
    prefix: --INCLUDE_NON_PRIMARY_ALIGNMENTS
    valueFrom: '$(self === null ? null : String(self))'
- id: interleave
  type:
  - 'null'
  - boolean
  doc: Will generate an interleaved fastq if paired, each line will have /1 or /2 to describe which end
    it came from
  inputBinding:
    position: 101
    prefix: --INTERLEAVE
    valueFrom: '$(self === null ? null : String(self))'
- id: max_records_in_ram
  type:
  - 'null'
  - int
  doc: When writing files that need to be sorted, this will specify the number of records stored in RAM
    before spilling to disk. Increasing this number reduces the number of file handles needed to sort
    the file, and increases the amount of RAM needed.
  inputBinding:
    position: 101
    prefix: --MAX_RECORDS_IN_RAM
- id: output_dir
  type:
  - 'null'
  - string
  doc: Directory in which to output the FASTQ file(s). Used only when OUTPUT_PER_RG is true.
  inputBinding:
    position: 101
    prefix: --OUTPUT_DIR
- id: output_per_rg
  type:
  - 'null'
  - boolean
  doc: Output a FASTQ file per read group (two FASTQ files per read group if the group is paired).
  inputBinding:
    position: 101
    prefix: --OUTPUT_PER_RG
    valueFrom: '$(self === null ? null : String(self))'
- id: quality
  type:
  - 'null'
  - int
  doc: End-trim reads using the phred/bwa quality trimming algorithm and this quality.
  inputBinding:
    position: 101
    prefix: --QUALITY
- id: quality_tag_group
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --QUALITY_TAG_GROUP
  doc: List of comma separated tag values to extract from Input SAM/BAM to be used as read qualities
  inputBinding:
    position: 101
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Whether to suppress job-summary info on System.err.
  inputBinding:
    position: 101
    prefix: --QUIET
    valueFrom: '$(self === null ? null : String(self))'
- id: re_reverse
  type:
  - 'null'
  - boolean
  doc: Re-reverse bases and qualities of reads with negative strand flag set before writing them to FASTQ
  inputBinding:
    position: 101
    prefix: --RE_REVERSE
    valueFrom: '$(self === null ? null : String(self))'
- id: read1_max_bases_to_write
  type:
  - 'null'
  - int
  doc: The maximum number of bases to write from read 1 after trimming. If there are fewer than this many
    bases left after trimming, all will be written. If this value is null then all bases left after trimming
    will be written.
  inputBinding:
    position: 101
    prefix: --READ1_MAX_BASES_TO_WRITE
- id: read1_trim
  type:
  - 'null'
  - int
  doc: The number of bases to trim from the beginning of read 1.
  inputBinding:
    position: 101
    prefix: --READ1_TRIM
- id: read2_max_bases_to_write
  type:
  - 'null'
  - int
  doc: The maximum number of bases to write from read 2 after trimming. If there are fewer than this many
    bases left after trimming, all will be written. If this value is null then all bases left after trimming
    will be written.
  inputBinding:
    position: 101
    prefix: --READ2_MAX_BASES_TO_WRITE
- id: read2_trim
  type:
  - 'null'
  - int
  doc: The number of bases to trim from the beginning of read 2.
  inputBinding:
    position: 101
    prefix: --READ2_TRIM
- id: reference_sequence
  type:
  - 'null'
  - File
  secondaryFiles:
  - .fai
  - ^.dict
  doc: Reference sequence file.
  inputBinding:
    position: 101
    prefix: --REFERENCE_SEQUENCE
- id: rg_tag
  type:
  - 'null'
  - string
  doc: The read group tag (PU or ID) to be used to output a FASTQ file per read group.
  inputBinding:
    position: 101
    prefix: --RG_TAG
- id: second_end_fastq
  type:
  - 'null'
  - string
  doc: Output FASTQ file (if paired, second end of the pair FASTQ).
  inputBinding:
    position: 101
    prefix: --SECOND_END_FASTQ
- id: tag_group_seperator
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --TAG_GROUP_SEPERATOR
  doc: List of any sequences (e.g. 'AACCTG`) to put in between each comma separated list of sequence tags
    in each SEQUENCE_TAG_GROUP (STG)
  inputBinding:
    position: 101
- id: tmp_dir
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --TMP_DIR
  doc: One or more directories with space available to be used by this program for temporary storage of
    working files
  inputBinding:
    position: 101
- id: unpaired_fastq
  type:
  - 'null'
  - string
  doc: Output FASTQ file for unpaired reads; may only be provided in paired-FASTQ mode
  inputBinding:
    position: 101
    prefix: --UNPAIRED_FASTQ
- id: use_jdk_deflater
  type:
  - 'null'
  - boolean
  doc: Use the JDK Deflater instead of the Intel Deflater for writing compressed output
  inputBinding:
    position: 101
    prefix: --USE_JDK_DEFLATER
    valueFrom: '$(self === null ? null : String(self))'
- id: use_jdk_inflater
  type:
  - 'null'
  - boolean
  doc: Use the JDK Inflater instead of the Intel Inflater for reading compressed input
  inputBinding:
    position: 101
    prefix: --USE_JDK_INFLATER
    valueFrom: '$(self === null ? null : String(self))'
- id: validation_stringency
  type:
  - 'null'
  - string
  doc: 'Validation stringency for all SAM files read by this program. Setting stringency to SILENT can
    improve performance when processing a BAM file in which variable-length data (read, qualities, tags)
    do not otherwise need to be decoded. Possible values: {STRICT, LENIENT, SILENT}'
  inputBinding:
    position: 101
    prefix: --VALIDATION_STRINGENCY
- id: verbosity
  type:
  - 'null'
  - string
  doc: 'Control verbosity of logging. Possible values: {ERROR, WARNING, INFO, DEBUG}'
  inputBinding:
    position: 101
    prefix: --VERBOSITY
- id: java_options
  type:
  - 'null'
  - string
  doc: Java options for the GATK launcher, for example -Xmx4g
  inputBinding:
    position: 101
    prefix: --java-options
outputs:
- id: fastq_output
  type:
  - 'null'
  - File
  doc: Output FASTQ file (single-end fastq or, if paired, first end of the pair FASTQ). Cannot be used
    in conjunction with argument(s) OUTPUT_PER_RG (OPRG) COMPRESS_OUTPUTS_PER_RG (GZOPRG) OUTPUT_DIR (ODIR)
  outputBinding:
    glob: '$(inputs.fastq ? inputs.fastq : [])'
- id: output_dir_output
  type:
    type: array
    items: File
  doc: Directory in which to output the FASTQ file(s). Used only when OUTPUT_PER_RG is true (files written
    into the directory)
  outputBinding:
    glob: '$(inputs.output_dir ? inputs.output_dir + "/*" : [])'
- id: second_end_fastq_output
  type:
  - 'null'
  - File
  doc: Output FASTQ file (if paired, second end of the pair FASTQ).
  outputBinding:
    glob: '$(inputs.second_end_fastq ? inputs.second_end_fastq : [])'
- id: unpaired_fastq_output
  type:
  - 'null'
  - File
  doc: Output FASTQ file for unpaired reads; may only be provided in paired-FASTQ mode
  outputBinding:
    glob: '$(inputs.unpaired_fastq ? inputs.unpaired_fastq : [])'
- id: tag_group_fastqs
  type:
    type: array
    items: File
  doc: 'All FASTQ files written to the working directory: the read FASTQ files and one file per tag group,
    named by the tag names (for example CR.fastq or CB_UR.fastq)'
  outputBinding:
    glob:
    - '*.fastq'
    - '*.fastq.gz'
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing: '$([].concat((inputs.output_dir ? [{"entry":{"class":"Directory","listing":[]},"entryname":inputs.output_dir,"writable":true}]
    : [])))'
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
