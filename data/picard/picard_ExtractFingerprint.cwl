cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - ExtractFingerprint
label: picard_ExtractFingerprint
doc: "Computes/Extracts the fingerprint genotype likelihoods from the supplied file.
  It is given as a list of PLs at the fingerprinting sites.\n\nTool homepage: http://broadinstitute.github.io/picard/"
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
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created (e.g. BAM and VCF).
    default: 5
    inputBinding:
      position: 101
      prefix: --COMPRESSION_LEVEL
  - id: contamination
    type:
      - 'null'
      - float
    doc: A value of estimated contamination in the input. A non-zero value will 
      cause the program to provide a better estimate of the fingerprint in the 
      presence of contaminating reads
    default: 0.0
    inputBinding:
      position: 101
      prefix: --CONTAMINATION
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
  - id: extract_contamination
    type:
      - 'null'
      - boolean
    doc: Extract a fingerprint for the contaminating sample (instead of the 
      contaminated sample).
    default: false
    inputBinding:
      position: 101
      prefix: --EXTRACT_CONTAMINATION
  - id: extract_non_representatives_too
    type:
      - 'null'
      - boolean
    doc: When true, code will extract variants for every snp in the haplotype 
      database, not only the representative one.
    default: false
    inputBinding:
      position: 101
      prefix: --EXTRACT_NON_REPRESENTATIVES_TOO
  - id: haplotype_map
    type: File
    doc: A file of haplotype information. The file lists a set of SNPs, 
      optionally arranged in high-LD blocks, to be used for fingerprinting.
    inputBinding:
      position: 101
      prefix: --HAPLOTYPE_MAP
  - id: input
    type: File
    doc: Input SAM/BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: locus_max_reads
    type:
      - 'null'
      - int
    doc: The maximum number of reads to use as evidence for any given locus.
    default: 50
    inputBinding:
      position: 101
      prefix: --LOCUS_MAX_READS
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
  - id: sample_alias
    type:
      - 'null'
      - string
    doc: The sample alias to associate with the resulting fingerprint.
    inputBinding:
      position: 101
      prefix: --SAMPLE_ALIAS
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
    doc: Output fingerprint file (VCF).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
