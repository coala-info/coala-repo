cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - BaitDesigner
label: picard_BaitDesigner
doc: Designs oligonucleotide baits for hybrid selection reactions. This tool is 
  used to design custom bait sets for hybrid selection experiments. It outputs 
  interval_list files of both bait and target sequences as well as the actual 
  bait sequences in FastA format.
inputs:
  - id: design_name
    type: string
    doc: The name of the bait design
    inputBinding:
      position: 101
      prefix: --DESIGN_NAME
  - id: reference_sequence
    type: File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: targets
    type:
      - 'null'
      - File
    doc: The file with design parameters and targets
    inputBinding:
      position: 101
      prefix: --TARGETS
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
    inputBinding:
      position: 101
      prefix: --BAIT_OFFSET
  - id: bait_size
    type:
      - 'null'
      - int
    doc: The length of each individual bait to design
    inputBinding:
      position: 101
      prefix: --BAIT_SIZE
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
  - id: design_on_target_strand
    type:
      - 'null'
      - boolean
    doc: If true design baits on the strand of the target feature, if false 
      always design on the + strand of the genome.
    inputBinding:
      position: 101
      prefix: --DESIGN_ON_TARGET_STRAND
  - id: design_strategy
    type:
      - 'null'
      - string
    doc: 'The design strategy to use to layout baits across each target. Possible
      values: {CenteredConstrained, FixedOffset, Simple}'
    inputBinding:
      position: 101
      prefix: --DESIGN_STRATEGY
  - id: fill_pools
    type:
      - 'null'
      - boolean
    doc: If true, fill up the pools with alternating fwd and rc copies of all 
      baits. Equal copies of all baits will always be maintained
    inputBinding:
      position: 101
      prefix: --FILL_POOLS
  - id: left_primer
    type:
      - 'null'
      - string
    doc: The left amplification primer to prepend to all baits for synthesis
    inputBinding:
      position: 101
      prefix: --LEFT_PRIMER
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: merge_nearby_targets
    type:
      - 'null'
      - boolean
    doc: If true merge targets that are 'close enough' that designing against a 
      merged target would be more efficient.
    inputBinding:
      position: 101
      prefix: --MERGE_NEARBY_TARGETS
  - id: minimum_baits_per_target
    type:
      - 'null'
      - int
    doc: The minimum number of baits to design per target.
    inputBinding:
      position: 101
      prefix: --MINIMUM_BAITS_PER_TARGET
  - id: output_agilent_files
    type:
      - 'null'
      - boolean
    doc: If true also output .design.txt files per pool with one line per bait 
      sequence
    inputBinding:
      position: 101
      prefix: --OUTPUT_AGILENT_FILES
  - id: output_directory
    type: string
    doc: The output directory. If not provided then the DESIGN_NAME will be used
      as the output directory
    inputBinding:
      position: 101
      prefix: --OUTPUT_DIRECTORY
  - id: padding
    type:
      - 'null'
      - int
    doc: Pad the input targets by this amount when designing baits. Padding is 
      applied on both sides in this amount.
    inputBinding:
      position: 101
      prefix: --PADDING
  - id: pool_size
    type:
      - 'null'
      - int
    doc: The size of pools or arrays for synthesis. If no pool files are 
      desired, can be set to 0.
    inputBinding:
      position: 101
      prefix: --POOL_SIZE
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: repeat_tolerance
    type:
      - 'null'
      - int
    doc: Baits that have more than REPEAT_TOLERANCE soft or hard masked bases 
      will not be allowed
    inputBinding:
      position: 101
      prefix: --REPEAT_TOLERANCE
  - id: right_primer
    type:
      - 'null'
      - string
    doc: The right amplification primer to prepend to all baits for synthesis
    inputBinding:
      position: 101
      prefix: --RIGHT_PRIMER
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
  - id: output_output_directory
    type:
      - 'null'
      - Directory
    doc: The output directory. If not provided then the DESIGN_NAME will be used
      as the output directory
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
