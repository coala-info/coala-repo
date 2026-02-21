cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CheckFingerprint
label: picard_CheckFingerprint
doc: "Checks the sample identity of the sequence/genotype data in the provided file
  (SAM/BAM/CRAM or VCF) against a set of known genotypes in the supplied genotype
  file (in VCF format).\n\nTool homepage: http://broadinstitute.github.io/picard/"
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
  - id: exit_code_when_expected_sample_not_found
    type:
      - 'null'
      - int
    doc: When the expected fingerprint sample is not found in the genotypes 
      file, this exit code is returned.
    default: 1
    inputBinding:
      position: 101
      prefix: --EXIT_CODE_WHEN_EXPECTED_SAMPLE_NOT_FOUND
  - id: exit_code_when_no_valid_checks
    type:
      - 'null'
      - int
    doc: When all LOD score are zero, exit with this value.
    default: 2
    inputBinding:
      position: 101
      prefix: --EXIT_CODE_WHEN_NO_VALID_CHECKS
  - id: expected_sample_alias
    type:
      - 'null'
      - string
    doc: This parameter can be used to specify which sample's genotypes to use 
      from the expected VCF file (the GENOTYPES file).
    inputBinding:
      position: 101
      prefix: --EXPECTED_SAMPLE_ALIAS
  - id: genotype_lod_threshold
    type:
      - 'null'
      - float
    doc: When counting haplotypes checked and matching, count only haplotypes 
      where the most likely haplotype achieves at least this LOD.
    default: 5.0
    inputBinding:
      position: 101
      prefix: --GENOTYPE_LOD_THRESHOLD
  - id: genotypes
    type: File
    doc: File of genotypes (VCF) to be used in comparison. May contain any 
      number of genotypes; CheckFingerprint will use only those that are usable 
      for fingerprinting.
    inputBinding:
      position: 101
      prefix: --GENOTYPES
  - id: haplotype_map
    type: File
    doc: The file lists a set of SNPs, optionally arranged in high-LD blocks, to
      be used for fingerprinting.
    inputBinding:
      position: 101
      prefix: --HAPLOTYPE_MAP
  - id: ignore_read_groups
    type:
      - 'null'
      - boolean
    doc: If the input is a SAM/BAM/CRAM, and this parameter is true, treat the 
      entire input BAM as one single read group in the calculation.
    default: false
    inputBinding:
      position: 101
      prefix: --IGNORE_READ_GROUPS
  - id: input
    type: File
    doc: Input file SAM/BAM/CRAM or VCF. If a VCF is used, it must have at least
      one sample.
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
  - id: observed_sample_alias
    type:
      - 'null'
      - string
    doc: If the input is a VCF, this parameters used to select which sample's 
      data in the VCF to use.
    inputBinding:
      position: 101
      prefix: --OBSERVED_SAMPLE_ALIAS
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
    type:
      - 'null'
      - File
    doc: Reference sequence file.
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
  - id: detail_output
    type: File
    doc: The text file to which to write detail metrics. Required. Cannot be 
      used in conjunction with argument(s) OUTPUT (O)
    outputBinding:
      glob: $(inputs.detail_output)
  - id: output
    type: File
    doc: The base prefix of output files to write. The summary metrics will have
      the file extension '.fingerprinting_summary_metrics' and the detail 
      metrics will have the extension '.fingerprinting_detail_metrics'.
    outputBinding:
      glob: $(inputs.output)
  - id: summary_output
    type: File
    doc: The text file to which to write summary metrics. Required. Cannot be 
      used in conjunction with argument(s) OUTPUT (O)
    outputBinding:
      glob: $(inputs.summary_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
