cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - BamToBfq
label: gatk_BamToBfq
doc: 'Converts a BAM file into a BFQ (binary fastq formatted) file. The BFQ format is the input format
  to some tools like Maq aligner.


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: analysis_dir
    type: string
    doc: The analysis directory for the binary output file.
    inputBinding:
      position: 101
      prefix: --ANALYSIS_DIR
  - id: flowcell_barcode
    type:
      - 'null'
      - string
    doc: Flowcell barcode (e.g. 30PYMAAXX). Required. Cannot be used in conjunction with argument(s) OUTPUT_FILE_PREFIX
    inputBinding:
      position: 101
      prefix: --FLOWCELL_BARCODE
  - id: input
    type: File
    doc: The BAM file to parse.
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
      prefix: --INPUT
  - id: output_file_prefix
    type:
      - 'null'
      - string
    doc: Prefix for all output files Required. Cannot be used in conjunction with argument(s) FLOWCELL_BARCODE
      (F) LANE (L)
    inputBinding:
      position: 101
      prefix: --OUTPUT_FILE_PREFIX
  - id: paired_run
    type: boolean
    doc: 'Whether this is a paired-end run. Required. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --PAIRED_RUN
      valueFrom: $(String(self))
  - id: bases_to_write
    type:
      - 'null'
      - int
    doc: The number of bases from each read to write to the bfq file. If this is non-null, then only the
      first BASES_TO_WRITE bases from each read will be written.
    inputBinding:
      position: 101
      prefix: --BASES_TO_WRITE
  - id: clip_adapters
    type:
      - 'null'
      - boolean
    doc: 'Whether to clip adapters from the reads Default value: true. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --CLIP_ADAPTERS
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
  - id: include_non_pf_reads
    type:
      - 'null'
      - boolean
    doc: 'Whether to include non-PF reads Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --INCLUDE_NON_PF_READS
      valueFrom: $(String(self))
  - id: lane
    type:
      - 'null'
      - int
    doc: Lane number. Cannot be used in conjunction with argument(s) OUTPUT_FILE_PREFIX
    inputBinding:
      position: 101
      prefix: --LANE
  - id: read_chunk_size
    type:
      - 'null'
      - int
    doc: 'Number of reads to break into individual groups for alignment Default value: 2000000.'
    inputBinding:
      position: 101
      prefix: --READ_CHUNK_SIZE
  - id: read_name_prefix
    type:
      - 'null'
      - string
    doc: Prefix to be stripped off the beginning of all read names (to make them short enough to run in
      Maq) Cannot be used in conjunction with argument(s) RUN_BARCODE (RB)
    inputBinding:
      position: 101
      prefix: --READ_NAME_PREFIX
  - id: reads_to_align
    type:
      - 'null'
      - int
    doc: Number of reads to align (null = all).
    inputBinding:
      position: 101
      prefix: --READS_TO_ALIGN
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
  - id: run_barcode
    type:
      - 'null'
      - string
    doc: Deprecated option; use READ_NAME_PREFIX instead Cannot be used in conjunction with argument(s)
      READ_NAME_PREFIX
    inputBinding:
      position: 101
      prefix: --RUN_BARCODE
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
  - id: analysis_dir_out
    type: Directory
    doc: Directory that receives the binary files.
    outputBinding:
      glob: $(inputs.analysis_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.analysis_dir)
        entry: '$({class: ''Directory'', listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
