cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- MergeBamAlignment
label: gatk_MergeBamAlignment
doc: |-
  Merge alignment data from a SAM or BAM with data in an unmapped BAM file. Summary A command-line tool for merging BAM/SAM alignment info from a third-party aligner with the data in an unmapped BAM file, producing a third BAM file that has alignment data (from the aligner) and all the remaining data from the unmapped BAM. Quick note: this is not a tool for taking multiple sam files and creating a bigger file by merging them. For that use-case, see {@link MergeSamFiles}. Details Many alignment tools (still!) require fastq format input. The unmapped bam may contain useful information that will be lost in the conversion to fastq (meta-data like sample alias, library, barcodes, etc., and read-level tags.) This tool takes an unaligned bam with meta-data, and the aligned bam produced by calling {@link SamToFastq} and then passing the result to an aligner/mapper. It produces a new SAM file that includes all aligned and unaligned reads and also carries forward additional read attributes from the unmapped BAM (attributes that are otherwise lost in the process of converting to fastq). The resulting file will be valid for use by Picard and GATK tools. The output may be coordinate-sorted, in which case the tags, NM, MD, and UQ will be calculated and populated, or query-name sorted, in which case the tags will not be calculated or populated.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: output
  type: string
  doc: Merged SAM or BAM file to write to.
  inputBinding:
    position: 101
    prefix: --OUTPUT
- id: reference_sequence
  type: File
  secondaryFiles:
  - .fai
  - ^.dict
  doc: Reference sequence file.
  inputBinding:
    position: 101
    prefix: --REFERENCE_SEQUENCE
- id: unmapped_bam
  type: File
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: Original SAM or BAM file of unmapped reads, which must be in queryname order. Reads MUST be unmapped.
  inputBinding:
    position: 101
    prefix: --UNMAPPED_BAM
- id: add_mate_cigar
  type:
  - 'null'
  - boolean
  doc: Adds the mate CIGAR tag (MC) if true, does not if false.
  inputBinding:
    position: 101
    prefix: --ADD_MATE_CIGAR
    valueFrom: '$(self === null ? null : String(self))'
- id: add_pg_tag_to_reads
  type:
  - 'null'
  - boolean
  doc: Add PG tag to each read in a SAM or BAM
  inputBinding:
    position: 101
    prefix: --ADD_PG_TAG_TO_READS
    valueFrom: '$(self === null ? null : String(self))'
- id: aligned_bam
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --ALIGNED_BAM
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: SAM or BAM file(s) with alignment data.
  inputBinding:
    position: 101
- id: aligned_reads_only
  type:
  - 'null'
  - boolean
  doc: Whether to output only aligned reads.
  inputBinding:
    position: 101
    prefix: --ALIGNED_READS_ONLY
    valueFrom: '$(self === null ? null : String(self))'
- id: aligner_proper_pair_flags
  type:
  - 'null'
  - boolean
  doc: Use the aligner's idea of what a proper pair is rather than computing in this program.
  inputBinding:
    position: 101
    prefix: --ALIGNER_PROPER_PAIR_FLAGS
    valueFrom: '$(self === null ? null : String(self))'
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
- id: attributes_to_remove
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --ATTRIBUTES_TO_REMOVE
  doc: Attributes from the alignment record that should be removed when merging. This overrides ATTRIBUTES_TO_RETAIN
    if they share common tags.
  inputBinding:
    position: 101
- id: attributes_to_retain
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --ATTRIBUTES_TO_RETAIN
  doc: Reserved alignment attributes (tags starting with X, Y, or Z) that should be brought over from
    the alignment data when merging.
  inputBinding:
    position: 101
- id: attributes_to_reverse
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --ATTRIBUTES_TO_REVERSE
  doc: Attributes on negative strand reads that need to be reversed.
  inputBinding:
    position: 101
- id: attributes_to_reverse_complement
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --ATTRIBUTES_TO_REVERSE_COMPLEMENT
  doc: Attributes on negative strand reads that need to be reverse complemented.
  inputBinding:
    position: 101
- id: clip_adapters
  type:
  - 'null'
  - boolean
  doc: Whether to clip adapters where identified.
  inputBinding:
    position: 101
    prefix: --CLIP_ADAPTERS
    valueFrom: '$(self === null ? null : String(self))'
- id: clip_overlapping_reads
  type:
  - 'null'
  - boolean
  doc: For paired reads, clip the 3' end of each read if necessary so that it does not extend past the
    5' end of its mate. Reads are first soft clipped so that the 3' aligned end of each read does not
    extend past the 5' aligned end of its mate. If HARD_CLIP_OVERLAPPING_READS is also true, then reads
    are additionally hard clipped so that the 3' unclipped end of each read does not extend past the 5'
    unclipped end of its mate. Hard clipped bases and their qualities are stored in the XB and XQ tags,
    respectively.
  inputBinding:
    position: 101
    prefix: --CLIP_OVERLAPPING_READS
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
- id: expected_orientations
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --EXPECTED_ORIENTATIONS
  doc: 'The expected orientation of proper read pairs. Replaces JUMP_SIZE Possible values: {FR, RF, TANDEM}'
  inputBinding:
    position: 101
- id: hard_clip_overlapping_reads
  type:
  - 'null'
  - boolean
  doc: If true, hard clipping will be applied to overlapping reads. By default, soft clipping is used.
  inputBinding:
    position: 101
    prefix: --HARD_CLIP_OVERLAPPING_READS
    valueFrom: '$(self === null ? null : String(self))'
- id: include_secondary_alignments
  type:
  - 'null'
  - boolean
  doc: If false, do not write secondary alignments to output.
  inputBinding:
    position: 101
    prefix: --INCLUDE_SECONDARY_ALIGNMENTS
    valueFrom: '$(self === null ? null : String(self))'
- id: is_bisulfite_sequence
  type:
  - 'null'
  - boolean
  doc: Whether the lane is bisulfite sequence (used when calculating the NM tag).
  inputBinding:
    position: 101
    prefix: --IS_BISULFITE_SEQUENCE
    valueFrom: '$(self === null ? null : String(self))'
- id: jump_size
  type:
  - 'null'
  - int
  doc: The expected jump size (required if this is a jumping library). Deprecated. Use EXPECTED_ORIENTATIONS
    instead
  inputBinding:
    position: 101
    prefix: --JUMP_SIZE
- id: matching_dictionary_tags
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --MATCHING_DICTIONARY_TAGS
  doc: List of Sequence Records tags that must be equal (if present) in the reference dictionary and in
    the aligned file. Mismatching tags will cause an error if in this list, and a warning otherwise.
  inputBinding:
    position: 101
- id: max_insertions_or_deletions
  type:
  - 'null'
  - int
  doc: The maximum number of insertions or deletions permitted for an alignment to be included. Alignments
    with more than this many insertions or deletions will be ignored. Set to -1 to allow any number of
    insertions or deletions.
  inputBinding:
    position: 101
    prefix: --MAX_INSERTIONS_OR_DELETIONS
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
- id: min_unclipped_bases
  type:
  - 'null'
  - int
  doc: If UNMAP_CONTAMINANT_READS is set, require this many unclipped bases or else the read will be marked
    as contaminant.
  inputBinding:
    position: 101
    prefix: --MIN_UNCLIPPED_BASES
- id: paired_run
  type:
  - 'null'
  - boolean
  doc: DEPRECATED. This argument is ignored and will be removed.
  inputBinding:
    position: 101
    prefix: --PAIRED_RUN
    valueFrom: '$(self === null ? null : String(self))'
- id: primary_alignment_strategy
  type:
  - 'null'
  - string
  doc: Strategy for selecting primary alignment when the aligner has provided more than one alignment
    for a pair or fragment, and none are marked as primary, more than one is marked as primary, or the
    primary alignment is filtered out for some reason. For all strategies, ties are resolved arbitrarily.
  inputBinding:
    position: 101
    prefix: --PRIMARY_ALIGNMENT_STRATEGY
- id: program_group_command_line
  type:
  - 'null'
  - string
  doc: The command line of the program group (if not supplied by the aligned file).
  inputBinding:
    position: 101
    prefix: --PROGRAM_GROUP_COMMAND_LINE
- id: program_group_name
  type:
  - 'null'
  - string
  doc: The name of the program group (if not supplied by the aligned file).
  inputBinding:
    position: 101
    prefix: --PROGRAM_GROUP_NAME
- id: program_group_version
  type:
  - 'null'
  - string
  doc: The version of the program group (if not supplied by the aligned file).
  inputBinding:
    position: 101
    prefix: --PROGRAM_GROUP_VERSION
- id: program_record_id
  type:
  - 'null'
  - string
  doc: The program group ID of the aligner (if not supplied by the aligned file).
  inputBinding:
    position: 101
    prefix: --PROGRAM_RECORD_ID
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Whether to suppress job-summary info on System.err.
  inputBinding:
    position: 101
    prefix: --QUIET
    valueFrom: '$(self === null ? null : String(self))'
- id: read1_aligned_bam
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --READ1_ALIGNED_BAM
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: SAM or BAM file(s) with alignment data from the first read of a pair.
  inputBinding:
    position: 101
- id: read1_trim
  type:
  - 'null'
  - int
  doc: The number of bases trimmed from the beginning of read 1 prior to alignment
  inputBinding:
    position: 101
    prefix: --READ1_TRIM
- id: read2_aligned_bam
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --READ2_ALIGNED_BAM
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: SAM or BAM file(s) with alignment data from the second read of a pair.
  inputBinding:
    position: 101
- id: read2_trim
  type:
  - 'null'
  - int
  doc: The number of bases trimmed from the beginning of read 2 prior to alignment
  inputBinding:
    position: 101
    prefix: --READ2_TRIM
- id: sort_order
  type:
  - 'null'
  - string
  doc: 'The order in which the merged reads should be output. Possible values: {unsorted, queryname, coordinate,
    duplicate, unknown}'
  inputBinding:
    position: 101
    prefix: --SORT_ORDER
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
- id: unmap_contaminant_reads
  type:
  - 'null'
  - boolean
  doc: Detect reads originating from foreign organisms (e.g. bacterial DNA in a non-bacterial sample),and
    unmap + label those reads accordingly.
  inputBinding:
    position: 101
    prefix: --UNMAP_CONTAMINANT_READS
    valueFrom: '$(self === null ? null : String(self))'
- id: unmapped_read_strategy
  type:
  - 'null'
  - string
  doc: 'How to deal with alignment information in reads that are being unmapped (e.g. due to cross-species
    contamination.) Currently ignored unless UNMAP_CONTAMINANT_READS = true. Note that the DO_NOT_CHANGE
    strategy will actually reset the cigar and set the mapping quality on unmapped reads since otherwisethe
    result will be an invalid record. To force no change use the DO_NOT_CHANGE_INVALID strategy. Possible
    values: {COPY_TO_TAG, DO_NOT_CHANGE, DO_NOT_CHANGE_INVALID, MOVE_TO_TAG}'
  inputBinding:
    position: 101
    prefix: --UNMAPPED_READ_STRATEGY
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
- id: output_output
  type: File
  doc: Merged SAM or BAM file to write to.
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
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
