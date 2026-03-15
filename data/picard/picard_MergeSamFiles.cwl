cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - MergeSamFiles
label: picard_MergeSamFiles
doc: Merges multiple SAM/BAM/CRAM (and/or) files into a single file. This tool 
  is used for combining SAM/BAM/CRAM (and/or) files from different runs or read 
  groups into a single file, similarly to the "merge" function of Samtools.
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: SAM/BAM/CRAM input file. This argument must be specified at least once.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: SAM/BAM/CRAM file to write merged result to
    inputBinding:
      position: 101
      prefix: --OUTPUT
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
    doc: If true, assume that the input files are in the same sort order as the 
      requested output sort order, even if their headers say otherwise.
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
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
  - id: intervals
    type:
      - 'null'
      - File
    doc: An interval list file that contains the locations of the positions to 
      merge. Assume sam are sorted and indexed.
    inputBinding:
      position: 101
      prefix: --INTERVALS
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: merge_sequence_dictionaries
    type:
      - 'null'
      - boolean
    doc: Merge the sequence dictionaries
    inputBinding:
      position: 101
      prefix: --MERGE_SEQUENCE_DICTIONARIES
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
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'Sort order of output file. Possible values: {unsorted, queryname, coordinate,
      duplicate, unknown}'
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
  - id: use_threading
    type:
      - 'null'
      - boolean
    doc: Option to create a background thread to encode, compress and write to 
      disk the output file.
    inputBinding:
      position: 101
      prefix: --USE_THREADING
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
    doc: SAM/BAM/CRAM file to write merged result to
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
