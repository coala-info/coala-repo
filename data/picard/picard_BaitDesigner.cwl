cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - BaitDesigner
label: picard_BaitDesigner
doc: "Designs oligonucleotide baits for hybrid selection reactions. This tool is used
  to design custom bait sets for hybrid selection experiments. It outputs interval_list
  files of both bait and target sequences as well as the actual bait sequences in
  FastA format.\n\nTool homepage: http://broadinstitute.github.io/picard/"
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
  - id: bait_offset
    type:
      - 'null'
      - int
    doc: The desired offset between the start of one bait and the start of 
      another bait for the same target.
    default: 80
    inputBinding:
      position: 101
      prefix: --BAIT_OFFSET
  - id: bait_size
    type:
      - 'null'
      - int
    doc: The length of each individual bait to design
    default: 120
    inputBinding:
      position: 101
      prefix: --BAIT_SIZE
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
  - id: design_name
    type: string
    doc: The name of the bait design
    inputBinding:
      position: 101
      prefix: --DESIGN_NAME
  - id: design_on_target_strand
    type:
      - 'null'
      - boolean
    doc: If true design baits on the strand of the target feature, if false 
      always design on the + strand of the genome.
    default: false
    inputBinding:
      position: 101
      prefix: --DESIGN_ON_TARGET_STRAND
  - id: design_strategy
    type:
      - 'null'
      - string
    doc: 'The design strategy to use to layout baits across each target. Possible
      values: {CenteredConstrained, FixedOffset, Simple}'
    default: FixedOffset
    inputBinding:
      position: 101
      prefix: --DESIGN_STRATEGY
  - id: fill_pools
    type:
      - 'null'
      - boolean
    doc: If true, fill up the pools with alternating fwd and rc copies of all 
      baits.
    default: true
    inputBinding:
      position: 101
      prefix: --FILL_POOLS
  - id: left_primer
    type:
      - 'null'
      - string
    doc: The left amplification primer to prepend to all baits for synthesis
    default: ATCGCACCAGCGTGT
    inputBinding:
      position: 101
      prefix: --LEFT_PRIMER
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
  - id: merge_nearby_targets
    type:
      - 'null'
      - boolean
    doc: If true merge targets that are 'close enough' that designing against a 
      merged target would be more efficient.
    default: true
    inputBinding:
      position: 101
      prefix: --MERGE_NEARBY_TARGETS
  - id: minimum_baits_per_target
    type:
      - 'null'
      - int
    doc: The minimum number of baits to design per target.
    default: 2
    inputBinding:
      position: 101
      prefix: --MINIMUM_BAITS_PER_TARGET
  - id: output_agilent_files
    type:
      - 'null'
      - boolean
    doc: If true also output .design.txt files per pool with one line per bait 
      sequence
    default: true
    inputBinding:
      position: 101
      prefix: --OUTPUT_AGILENT_FILES
  - id: padding
    type:
      - 'null'
      - int
    doc: Pad the input targets by this amount when designing baits.
    default: 0
    inputBinding:
      position: 101
      prefix: --PADDING
  - id: pool_size
    type:
      - 'null'
      - int
    doc: The size of pools or arrays for synthesis. If no pool files are 
      desired, can be set to 0.
    default: 55000
    inputBinding:
      position: 101
      prefix: --POOL_SIZE
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: reference_sequence
    type: File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: repeat_tolerance
    type:
      - 'null'
      - int
    doc: Baits that have more than REPEAT_TOLERANCE soft or hard masked bases 
      will not be allowed
    default: 50
    inputBinding:
      position: 101
      prefix: --REPEAT_TOLERANCE
  - id: right_primer
    type:
      - 'null'
      - string
    doc: The right amplification primer to prepend to all baits for synthesis
    default: CACTGCGGCTCCTCA
    inputBinding:
      position: 101
      prefix: --RIGHT_PRIMER
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    default: false
    inputBinding:
      position: 101
      prefix: --showHidden
  - id: targets
    type: File
    doc: The file with design parameters and targets
    inputBinding:
      position: 101
      prefix: --TARGETS
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
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: The output directory. If not provided then the DESIGN_NAME will be used
      as the output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
