cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - IdentifyContaminant
label: picard_IdentifyContaminant
doc: "Computes the fingerprint genotype likelihoods from the supplied SAM/BAM file
  and a contamination estimate. NOTA BENE: the fingerprint is provided for the contamination
  (by default) for the main sample. It is given as a list of PLs at the fingerprinting
  sites.\n\nTool homepage: http://broadinstitute.github.io/picard/"
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
    doc: A value of estimated contamination in the input.
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
  - id: extract_contaminated
    type:
      - 'null'
      - boolean
    doc: Extract a fingerprint for the contaminated sample (instead of the 
      contaminant). Setting to true changes the effect of SAMPLE_ALIAS when 
      null. It names the sample in the VCF <SAMPLE>, using the SM value from the
      SAM header.
    default: false
    inputBinding:
      position: 101
      prefix: --EXTRACT_CONTAMINATED
  - id: haplotype_map
    type: File
    doc: A file of haplotype information. The file lists a set of SNPs, 
      optionally arranged in high-LD blocks, to be used for fingerprinting.
    inputBinding:
      position: 101
      prefix: --HAPLOTYPE_MAP
  - id: input
    type: File
    doc: Input SAM or BAM file.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: locus_max_reads
    type:
      - 'null'
      - int
    doc: The maximum number of reads to use as evidence for any given locus. 
      This is provided as a way to limit the effect that any given locus may 
      have.
    default: 200
    inputBinding:
      position: 101
      prefix: --LOCUS_MAX_READS
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk. Increasing this number 
      reduces the number of file handles needed to sort the file, and increases 
      the amount of RAM needed.
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
    doc: The sample alias to associate with the resulting fingerprint. When 
      null, <SAMPLE> is extracted from the input file and 
      "<SAMPLE>-contamination" is used.
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
