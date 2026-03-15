cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CrosscheckFingerprints
label: picard_CrosscheckFingerprints
doc: Checks the odds that all data in the set of input files come from the same 
  individual. Can be used to cross-check readgroups, libraries, samples, or 
  files. Acceptable inputs include BAM/SAM/CRAM and VCF/GVCF files. Output 
  delivers LOD scores in the form of a CrosscheckMetric file.
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
      type: array
      items: string
    doc: One or more input files (or lists of files) with which to compare 
      fingerprints.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: allow_duplicate_reads
    type:
      - 'null'
      - boolean
    doc: Allow the use of duplicate reads in performing the comparison.
    inputBinding:
      position: 101
      prefix: --ALLOW_DUPLICATE_READS
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: calculate_tumor_aware_results
    type:
      - 'null'
      - boolean
    doc: Specifies whether the Tumor-aware result should be calculated.
    inputBinding:
      position: 101
      prefix: --CALCULATE_TUMOR_AWARE_RESULTS
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
  - id: crosscheck_by
    type:
      - 'null'
      - string
    doc: Specifies which data-type should be used as the basic comparison unit 
      (FILE, SAMPLE, LIBRARY, READGROUP).
    inputBinding:
      position: 101
      prefix: --CROSSCHECK_BY
  - id: crosscheck_mode
    type:
      - 'null'
      - string
    doc: An argument that controls how crosschecking with both INPUT and 
      SECOND_INPUT should occur.
    inputBinding:
      position: 101
      prefix: --CROSSCHECK_MODE
  - id: exit_code_when_mismatch
    type:
      - 'null'
      - int
    doc: When one or more mismatches between groups is detected, exit with this 
      value instead of 0.
    inputBinding:
      position: 101
      prefix: --EXIT_CODE_WHEN_MISMATCH
  - id: exit_code_when_no_valid_checks
    type:
      - 'null'
      - int
    doc: When all LOD scores are zero, exit with this value.
    inputBinding:
      position: 101
      prefix: --EXIT_CODE_WHEN_NO_VALID_CHECKS
  - id: expect_all_groups_to_match
    type:
      - 'null'
      - boolean
    doc: Expect all groups' fingerprints to match, irrespective of their sample 
      names.
    inputBinding:
      position: 101
      prefix: --EXPECT_ALL_GROUPS_TO_MATCH
  - id: genotyping_error_rate
    type:
      - 'null'
      - float
    doc: DEPRECATED. Assumed genotyping error rate.
    inputBinding:
      position: 101
      prefix: --GENOTYPING_ERROR_RATE
  - id: input_index_map
    type:
      - 'null'
      - File
    doc: A tsv with two columns and no header which maps the input files to 
      corresponding indices.
    inputBinding:
      position: 101
      prefix: --INPUT_INDEX_MAP
  - id: input_sample_file_map
    type:
      - 'null'
      - File
    doc: A tsv mapping the sample to the source file in INPUT.
    inputBinding:
      position: 101
      prefix: --INPUT_SAMPLE_FILE_MAP
  - id: input_sample_map
    type:
      - 'null'
      - File
    doc: A tsv mapping the sample as it appears in INPUT to how it should be 
      used for comparisons.
    inputBinding:
      position: 101
      prefix: --INPUT_SAMPLE_MAP
  - id: lod_threshold
    type:
      - 'null'
      - float
    doc: LOD score threshold for determining matches/mismatches.
    inputBinding:
      position: 101
      prefix: --LOD_THRESHOLD
  - id: loss_of_het_rate
    type:
      - 'null'
      - float
    doc: The rate at which a heterozygous genotype in a normal sample turns into
      a homozygous in the tumor.
    inputBinding:
      position: 101
      prefix: --LOSS_OF_HET_RATE
  - id: matrix_output
    type: string
    doc: Optional output file to write matrix of LOD scores to.
    inputBinding:
      position: 101
      prefix: --MATRIX_OUTPUT
  - id: max_effect_of_each_haplotype_block
    type:
      - 'null'
      - float
    doc: Maximal effect of any single haplotype block on outcome.
    inputBinding:
      position: 101
      prefix: --MAX_EFFECT_OF_EACH_HAPLOTYPE_BLOCK
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: Number of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: num_threads
    type:
      - 'null'
      - int
    doc: The number of threads to use to process files and generate 
      fingerprints.
    inputBinding:
      position: 101
      prefix: --NUM_THREADS
  - id: output
    type: string
    doc: Optional output file to write metrics to.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: output_errors_only
    type:
      - 'null'
      - boolean
    doc: If true, then only groups that do not relate to each other as expected 
      will have their LODs reported.
    inputBinding:
      position: 101
      prefix: --OUTPUT_ERRORS_ONLY
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
  - id: require_index_files
    type:
      - 'null'
      - boolean
    doc: Whether input files should only be parsed if index files are available.
    inputBinding:
      position: 101
      prefix: --REQUIRE_INDEX_FILES
  - id: sample_individual_map
    type:
      - 'null'
      - File
    doc: A tsv with two columns representing the individual with which each 
      sample is associated.
    inputBinding:
      position: 101
      prefix: --SAMPLE_INDIVIDUAL_MAP
  - id: second_input
    type:
      - 'null'
      - type: array
        items: string
    doc: A second set of input files (or lists of files) with which to compare 
      fingerprints.
    inputBinding:
      position: 101
      prefix: --SECOND_INPUT
  - id: second_input_index_map
    type:
      - 'null'
      - File
    doc: A tsv mapping the second input files to corresponding indices.
    inputBinding:
      position: 101
      prefix: --SECOND_INPUT_INDEX_MAP
  - id: second_input_sample_map
    type:
      - 'null'
      - File
    doc: A tsv mapping the sample as it appears in SECOND_INPUT to how it should
      be used for comparisons.
    inputBinding:
      position: 101
      prefix: --SECOND_INPUT_SAMPLE_MAP
  - id: tmp_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: One or more directories with space available to be used by this program
      for temporary storage.
    inputBinding:
      position: 101
      prefix: --TMP_DIR
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Deflater instead of the Intel Deflater for writing 
      compressed output.
    inputBinding:
      position: 101
      prefix: --USE_JDK_DEFLATER
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Inflater instead of the Intel Inflater for reading 
      compressed input.
    inputBinding:
      position: 101
      prefix: --USE_JDK_INFLATER
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: Validation stringency for all SAM files read by this program (STRICT, 
      LENIENT, SILENT).
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
  - id: output_matrix_output
    type:
      - 'null'
      - File
    doc: Optional output file to write matrix of LOD scores to.
    outputBinding:
      glob: $(inputs.matrix_output)
  - id: output_output
    type:
      - 'null'
      - File
    doc: Optional output file to write metrics to.
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
