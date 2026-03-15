cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CalculateFingerprintMetrics
label: picard_CalculateFingerprintMetrics
doc: Calculate statistics on fingerprints, checking their viability. This tool 
  collects various statistics that pertain to a single fingerprint and reports 
  the results in a metrics file.
inputs:
  - id: haplotype_map
    type: File
    doc: The file lists a set of SNPs, optionally arranged in high-LD blocks, to
      be used for fingerprinting.
    inputBinding:
      position: 101
      prefix: --HAPLOTYPE_MAP
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more input files (SAM/BAM/CRAM or VCF). This argument must be 
      specified at least once.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: The output file to write (Metrics).
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
  - id: calculate_by
    type:
      - 'null'
      - string
    doc: 'Specificies which data-type should be used as the basic unit. Possible values:
      {FILE, SAMPLE, LIBRARY, READGROUP}'
    inputBinding:
      position: 101
      prefix: --CALCULATE_BY
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
  - id: genotype_lod_threshold
    type:
      - 'null'
      - float
    doc: LOD score threshold for considering a genotype to be definitive.
    inputBinding:
      position: 101
      prefix: --GENOTYPE_LOD_THRESHOLD
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: number_of_sampling
    type:
      - 'null'
      - int
    doc: Number of randomization trials for calculating the DISCRIMINATORY_POWER
      metric.
    inputBinding:
      position: 101
      prefix: --NUMBER_OF_SAMPLING
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
  - id: output_output
    type: File
    doc: The output file to write (Metrics).
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
