cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectAlignmentSummaryMetrics
label: picard_CollectAlignmentSummaryMetrics
doc: Produces a summary of alignment metrics from a SAM or BAM file. This tool 
  takes a SAM/BAM file input and produces metrics detailing the quality of the 
  read alignments as well as the proportion of the reads that passed machine 
  signal-to-noise threshold quality filters.
inputs:
  - id: input
    type: File
    doc: Input SAM/BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: The file to write the output to.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: adapter_sequence
    type:
      - 'null'
      - type: array
        items: string
    doc: List of adapter sequences to use when processing the alignment metrics.
    inputBinding:
      position: 101
      prefix: --ADAPTER_SEQUENCE
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: If true (default), then the sort order in the header file will be 
      ignored.
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
  - id: collect_alignment_information
    type:
      - 'null'
      - boolean
    doc: A flag to disable the collection of actual alignment information. If 
      false, tool will only count READS, PF_READS, and NOISE_READS.
    inputBinding:
      position: 101
      prefix: --COLLECT_ALIGNMENT_INFORMATION
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
  - id: expected_pair_orientations
    type:
      - 'null'
      - type: array
        items: string
    doc: Paired-end reads that do not have this expected orientation will be 
      considered chimeric.
    inputBinding:
      position: 101
      prefix: --EXPECTED_PAIR_ORIENTATIONS
  - id: histogram_file
    type: string
    doc: If Provided, file to write read-length chart pdf.
    inputBinding:
      position: 101
      prefix: --HISTOGRAM_FILE
  - id: is_bisulfite_sequenced
    type:
      - 'null'
      - boolean
    doc: Whether the SAM or BAM file consists of bisulfite sequenced reads.
    inputBinding:
      position: 101
      prefix: --IS_BISULFITE_SEQUENCED
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: Paired-end reads above this insert size will be considered chimeric 
      along with inter-chromosomal pairs.
    inputBinding:
      position: 101
      prefix: --MAX_INSERT_SIZE
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: metric_accumulation_level
    type:
      - 'null'
      - type: array
        items: string
    doc: The level(s) at which to accumulate metrics.
    inputBinding:
      position: 101
      prefix: --METRIC_ACCUMULATION_LEVEL
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file. Note that while this argument isn't required, 
      without it a small subset (MISMATCH-related) of the metrics cannot be 
      calculated.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: stop_after
    type:
      - 'null'
      - int
    doc: Stop after processing N reads, mainly for debugging.
    inputBinding:
      position: 101
      prefix: --STOP_AFTER
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
    doc: The file to write the output to.
    outputBinding:
      glob: $(inputs.output)
  - id: output_histogram_file
    type:
      - 'null'
      - File
    doc: If Provided, file to write read-length chart pdf.
    outputBinding:
      glob: $(inputs.histogram_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
