cwlVersion: v1.2
class: CommandLineTool
baseCommand: DetectBeadSubstitutionErrors
label: dropseq_tools_DetectBeadSubstitutionErrors
doc: "Collapses umambiguously related small barcodes into larger neighbors. Unambiguously
  related barcodes are situations where a smaller barcode only has 1 neighbor within
  the edit distance threshold, so the barcode can not be collapsed to the wrong neighbor.
  These sorts of errors can be due to problems with barcode synthesis. Ambiguous barcodes
  are situations where a smaller neighbor has multiple larger neighbors. These barcodes
  can be optionally filtered.\n\nTool homepage: http://mccarrolllab.com/dropseq/"
inputs:
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line This 
      argument may be specified 0 or more times.
    default: 'null'
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: cell_barcode_tag
    type:
      - 'null'
      - string
    doc: The cell barcode tag.
    default: XC
    inputBinding:
      position: 101
      prefix: --CELL_BARCODE_TAG
  - id: compression_level
    type:
      - 'null'
      - string
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
  - id: echo_command_line
    type:
      - 'null'
      - boolean
    doc: Echo final command line before executing.
    inputBinding:
      position: 101
      prefix: -v
  - id: edit_distance
    type:
      - 'null'
      - string
    doc: The edit distance to collapse barcodes
    default: 1
    inputBinding:
      position: 101
      prefix: --EDIT_DISTANCE
  - id: filter_ambiguous
    type:
      - 'null'
      - boolean
    doc: Remove smaller barcodes that map at the edit distance to multiple 
      larger barcodes.
    default: true
    inputBinding:
      position: 101
      prefix: --FILTER_AMBIGUOUS
  - id: freq_common_substitution
    type:
      - 'null'
      - string
    doc: Only repair substitution patterns that occur at a base as more than 
      <FREQ_COMMON_SUBSTITUTION> of the total changes. We expect there to be a 
      single dominant barcode change [from say A->C at base 1] due to a 
      synthesis error at that base. In those cases, we want to perform repair, 
      but we don't want to arbitrarily combine barcodes together. Set this to 0 
      to combine everything...but testing has revealed that this will combine 
      barcodes capriciously so we don't recommend it!
    default: 0.8
    inputBinding:
      position: 101
      prefix: --FREQ_COMMON_SUBSTITUTION
  - id: input_file
    type: File
    doc: The input DropSeq BAM file to analyze This argument must be specified 
      at least once.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: jvm_heap_size
    type:
      - 'null'
      - string
    doc: Heap size to allocate for the JVM.
    default: 4g
    inputBinding:
      position: 101
      prefix: -m
  - id: max_records_in_ram
    type:
      - 'null'
      - string
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk. Increasing this number 
      reduces the number of file handles needed to sort the file, and increases 
      the amount of RAM needed.
    default: 500000
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: min_umis_per_cell
    type:
      - 'null'
      - string
    doc: The minimum number of UMIs required to consider a cell barcode for 
      collapse. Setting this number higher speeds up cleanup. Very small 
      barcodes will not contribute many UMIs, so are not a useful return on 
      investment. Suggested values range from 20 to 200.
    default: 20
    inputBinding:
      position: 101
      prefix: --MIN_UMIS_PER_CELL
  - id: molecular_barcode_tag
    type:
      - 'null'
      - string
    doc: The molecular barcode tag.
    default: XM
    inputBinding:
      position: 101
      prefix: --MOLECULAR_BARCODE_TAG
  - id: num_threads
    type:
      - 'null'
      - string
    doc: Number of threads to use. Defaults to 1.
    default: 1
    inputBinding:
      position: 101
      prefix: --NUM_THREADS
  - id: out_cell_barcode_tag
    type:
      - 'null'
      - string
    doc: The output barcode tag for the newly collapsed barcodes. Defaults to 
      the CELL_BARCODE_TAG if not set.
    default: 'null'
    inputBinding:
      position: 101
      prefix: --OUT_CELL_BARCODE_TAG
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: read_mq
    type:
      - 'null'
      - string
    doc: Read quality filter. Filters all reads lower than this mapping quality.
      Defaults to 10. Set to 0 to not filter reads by map quality.
    default: 10
    inputBinding:
      position: 101
      prefix: --READ_MQ
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    default: 'null'
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
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
        items: File
    doc: One or more directories with space available to be used by this program
      for temporary storage of working files This argument may be specified 0 or
      more times.
    default: 'null'
    inputBinding:
      position: 101
      prefix: --TMP_DIR
  - id: umi_bias_base
    type:
      - 'null'
      - string
    doc: Which base to scan for UMI bias. This is typically the last base of the
      UMI. If set to null, program will use the last base of the UMI.
    default: 'null'
    inputBinding:
      position: 101
      prefix: --UMI_BIAS_BASE
  - id: umi_bias_threshold
    type:
      - 'null'
      - string
    doc: The amount of bias (all UMIs for a cell have the same base) at which a 
      cell barcode is considered biased?
    default: 0.8
    inputBinding:
      position: 101
      prefix: --UMI_BIAS_THRESHOLD
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
    doc: Validation stringency for all SAM files read by this program. Setting 
      stringency to SILENT can improve performance when processing a BAM file in
      which variable-length data (read, qualities, tags) do not otherwise need 
      to be decoded.
    default: STRICT
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Control verbosity of logging.
    default: INFO
    inputBinding:
      position: 101
      prefix: --VERBOSITY
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BAM file with cell barcodes collapsed.
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_report
    type:
      - 'null'
      - File
    doc: Output report detailing which barcodes were merged, and what the 
      position of the substitution and intended/changed bases were for each pair
      of barcordes merged.
    outputBinding:
      glob: $(inputs.output_report)
  - id: output_summary
    type:
      - 'null'
      - File
    doc: Output the number of substitutions found at each base, from intended 
      sequence to neighbor sequence.
    outputBinding:
      glob: $(inputs.output_summary)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
