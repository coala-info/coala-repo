cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - DownsampleSam
label: picard_DownsampleSam
doc: "Downsample a SAM or BAM file. This tool applies a downsampling algorithm to
  a SAM or BAM file to retain only a (deterministically random) subset of the reads.
  Reads from the same template (e.g. read-pairs, secondary and supplementary reads)
  are all either kept or discarded as a unit.\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs:
  - id: accuracy
    type:
      - 'null'
      - float
    doc: The accuracy that the downsampler should try to achieve if the selected
      strategy supports it.
    default: 0.0001
    inputBinding:
      position: 101
      prefix: --ACCURACY
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
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
  - id: input
    type: File
    doc: The input SAM or BAM file to downsample.
    inputBinding:
      position: 101
      prefix: --INPUT
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
  - id: probability
    type:
      - 'null'
      - float
    doc: The probability of keeping any individual read, between 0 and 1.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --PROBABILITY
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed used for deterministic results.
    default: 1
    inputBinding:
      position: 101
      prefix: --RANDOM_SEED
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: The reference sequence file.
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
  - id: strategy
    type:
      - 'null'
      - string
    doc: 'The downsampling strategy to use. Possible values: {HighAccuracy, ConstantMemory,
      Chained}'
    default: ConstantMemory
    inputBinding:
      position: 101
      prefix: --STRATEGY
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
  - id: output
    type: File
    doc: The output, downsampled, SAM, BAM or CRAM file to write.
    outputBinding:
      glob: $(inputs.output)
  - id: metrics_file
    type:
      - 'null'
      - File
    doc: The metrics file (of type QualityYieldMetrics) which will contain 
      information about the downsampled file.
    outputBinding:
      glob: $(inputs.metrics_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
