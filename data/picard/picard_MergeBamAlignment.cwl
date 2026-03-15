cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - MergeBamAlignment
label: picard_MergeBamAlignment
doc: Merge alignment data from a SAM or BAM with data in an unmapped BAM file. A
  command-line tool for merging BAM/SAM alignment info from a third-party 
  aligner with the data in an unmapped BAM file, producing a third BAM file that
  has alignment data (from the aligner) and all the remaining data from the 
  unmapped BAM.
inputs:
  - id: output
    type: string
    doc: Merged SAM or BAM file to write to.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: unmapped_bam
    type:
      - 'null'
      - File
    doc: Original SAM or BAM file of unmapped reads, which must be in queryname 
      order. Reads MUST be unmapped.
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
  - id: add_pg_tag_to_reads
    type:
      - 'null'
      - boolean
    doc: Add PG tag to each read in a SAM or BAM
    inputBinding:
      position: 101
      prefix: --ADD_PG_TAG_TO_READS
  - id: aligned_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: SAM or BAM file(s) with alignment data. This argument may be specified 
      0 or more times.
    inputBinding:
      position: 101
      prefix: --ALIGNED_BAM
  - id: aligned_reads_only
    type:
      - 'null'
      - boolean
    doc: Whether to output only aligned reads.
    inputBinding:
      position: 101
      prefix: --ALIGNED_READS_ONLY
  - id: aligner_proper_pair_flags
    type:
      - 'null'
      - boolean
    doc: Use the aligner's idea of what a proper pair is rather than computing 
      in this program.
    inputBinding:
      position: 101
      prefix: --ALIGNER_PROPER_PAIR_FLAGS
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: attributes_to_remove
    type:
      - 'null'
      - type: array
        items: string
    doc: Attributes from the alignment record that should be removed when 
      merging. This overrides ATTRIBUTES_TO_RETAIN if they share common tags.
    inputBinding:
      position: 101
      prefix: --ATTRIBUTES_TO_REMOVE
  - id: attributes_to_retain
    type:
      - 'null'
      - type: array
        items: string
    doc: Reserved alignment attributes (tags starting with X, Y, or Z) that 
      should be brought over from the alignment data when merging.
    inputBinding:
      position: 101
      prefix: --ATTRIBUTES_TO_RETAIN
  - id: attributes_to_reverse
    type:
      - 'null'
      - type: array
        items: string
    doc: Attributes on negative strand reads that need to be reversed.
    inputBinding:
      position: 101
      prefix: --ATTRIBUTES_TO_REVERSE
  - id: attributes_to_reverse_complement
    type:
      - 'null'
      - type: array
        items: string
    doc: Attributes on negative strand reads that need to be reverse 
      complemented.
    inputBinding:
      position: 101
      prefix: --ATTRIBUTES_TO_REVERSE_COMPLEMENT
  - id: clip_adapters
    type:
      - 'null'
      - boolean
    doc: Whether to clip adapters where identified.
    inputBinding:
      position: 101
      prefix: --CLIP_ADAPTERS
  - id: clip_overlapping_reads
    type:
      - 'null'
      - boolean
    doc: For paired reads, clip the 3' end of each read if necessary so that it 
      does not extend past the 5' end of its mate.
    inputBinding:
      position: 101
      prefix: --CLIP_OVERLAPPING_READS
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
  - id: expected_orientations
    type:
      - 'null'
      - type: array
        items: string
    doc: 'The expected orientation of proper read pairs. Replaces JUMP_SIZE. Possible
      values: {FR, RF, TANDEM}'
    inputBinding:
      position: 101
      prefix: --EXPECTED_ORIENTATIONS
  - id: hard_clip_overlapping_reads
    type:
      - 'null'
      - boolean
    doc: If true, hard clipping will be applied to overlapping reads. By 
      default, soft clipping is used.
    inputBinding:
      position: 101
      prefix: --HARD_CLIP_OVERLAPPING_READS
  - id: include_secondary_alignments
    type:
      - 'null'
      - boolean
    doc: If false, do not write secondary alignments to output.
    inputBinding:
      position: 101
      prefix: --INCLUDE_SECONDARY_ALIGNMENTS
  - id: is_bisulfite_sequence
    type:
      - 'null'
      - boolean
    doc: Whether the lane is bisulfite sequence (used when calculating the NM 
      tag).
    inputBinding:
      position: 101
      prefix: --IS_BISULFITE_SEQUENCE
  - id: jump_size
    type:
      - 'null'
      - int
    doc: The expected jump size (required if this is a jumping library). 
      Deprecated. Use EXPECTED_ORIENTATIONS instead
    inputBinding:
      position: 101
      prefix: --JUMP_SIZE
  - id: matching_dictionary_tags
    type:
      - 'null'
      - type: array
        items: string
    doc: List of Sequence Records tags that must be equal (if present) in the 
      reference dictionary and in the aligned file.
    inputBinding:
      position: 101
      prefix: --MATCHING_DICTIONARY_TAGS
  - id: max_insertions_or_deletions
    type:
      - 'null'
      - int
    doc: The maximum number of insertions or deletions permitted for an 
      alignment to be included.
    inputBinding:
      position: 101
      prefix: --MAX_INSERTIONS_OR_DELETIONS
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: min_unclipped_bases
    type:
      - 'null'
      - int
    doc: If UNMAP_CONTAMINANT_READS is set, require this many unclipped bases or
      else the read will be marked as contaminant.
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
  - id: primary_alignment_strategy
    type:
      - 'null'
      - string
    doc: Strategy for selecting primary alignment when the aligner has provided 
      more than one alignment for a pair or fragment.
    inputBinding:
      position: 101
      prefix: --PRIMARY_ALIGNMENT_STRATEGY
  - id: program_group_command_line
    type:
      - 'null'
      - string
    doc: The command line of the program group (if not supplied by the aligned 
      file).
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
    doc: The program group ID of the aligner (if not supplied by the aligned 
      file).
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
  - id: read1_aligned_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: SAM or BAM file(s) with alignment data from the first read of a pair.
    inputBinding:
      position: 101
      prefix: --READ1_ALIGNED_BAM
  - id: read1_trim
    type:
      - 'null'
      - int
    doc: The number of bases trimmed from the beginning of read 1 prior to 
      alignment
    inputBinding:
      position: 101
      prefix: --READ1_TRIM
  - id: read2_aligned_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: SAM or BAM file(s) with alignment data from the second read of a pair.
    inputBinding:
      position: 101
      prefix: --READ2_ALIGNED_BAM
  - id: read2_trim
    type:
      - 'null'
      - int
    doc: The number of bases trimmed from the beginning of read 2 prior to 
      alignment
    inputBinding:
      position: 101
      prefix: --READ2_TRIM
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'The order in which the merged reads should be output. Possible values: {unsorted,
      queryname, coordinate, duplicate, unknown}'
    inputBinding:
      position: 101
      prefix: --SORT_ORDER
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
  - id: unmap_contaminant_reads
    type:
      - 'null'
      - boolean
    doc: Detect reads originating from foreign organisms (e.g. bacterial DNA in 
      a non-bacterial sample),and unmap + label those reads accordingly.
    inputBinding:
      position: 101
      prefix: --UNMAP_CONTAMINANT_READS
  - id: unmapped_read_strategy
    type:
      - 'null'
      - string
    doc: 'How to deal with alignment information in reads that are being unmapped.
      Possible values: {COPY_TO_TAG, DO_NOT_CHANGE, DO_NOT_CHANGE_INVALID, MOVE_TO_TAG}'
    inputBinding:
      position: 101
      prefix: --UNMAPPED_READ_STRATEGY
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
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Possible values:
      {STRICT, LENIENT, SILENT}'
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
    doc: Merged SAM or BAM file to write to.
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
