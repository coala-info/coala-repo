cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - CrosscheckReadGroupFingerprints
label: gatk_CrosscheckReadGroupFingerprints
doc: |-
  DEPRECATED: USE CrosscheckFingerprints.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: haplotype_map
    type: File
    inputBinding:
      position: 101
      prefix: --HAPLOTYPE_MAP
    doc: The file lists a set of SNPs, optionally arranged in high-LD blocks, to be
      used for fingerprinting. See https://gatk.broadinstitute.org/hc/en-us/articles/360035531672-Haplotype-map-format
      for details.
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --INPUT
    inputBinding:
      position: 101
    doc: One or more input files (or lists of files) with which to compare fingerprints.
      This argument must be specified at least once.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
      - pattern: .sbi
        required: false
  - id: allow_duplicate_reads
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --ALLOW_DUPLICATE_READS
    doc: 'Allow the use of duplicate reads in performing the comparison. Can be useful
      when duplicate marking has been overly aggressive and coverage is low. Default
      value: false. Possible values: {true, false}'
  - id: calculate_tumor_aware_results
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --CALCULATE_TUMOR_AWARE_RESULTS
      valueFrom: '$(self ? ''true'' : ''false'')'
    doc: 'Specifies whether the Tumor-aware result should be calculated. These are
      time consuming and can roughly double the runtime of the tool. When crosschecking
      many groups not calculating the tumor-aware results can result in a significant
      speedup. Default value: true. Possible values: {true, false}'
  - id: crosscheck_by
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --CROSSCHECK_BY
    doc: 'Specifies which data-type should be used as the basic comparison unit. Fingerprints
      from readgroups can be "rolled-up" to the LIBRARY, SAMPLE, or FILE level before
      being compared. Fingerprints from VCF can be be compared by SAMPLE or FILE.
      Default value: READGROUP. Possible values: {FILE, SAMPLE, LIBRARY, READGROUP}'
  - id: crosscheck_libraries
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --CROSSCHECK_LIBRARIES
    doc: 'Instead of producing the normal comparison of read-groups, roll fingerprints
      up to the library level and print out a library x library matrix with LOD scores.
      Default value: false. Possible values: {true, false}'
  - id: crosscheck_mode
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --CROSSCHECK_MODE
    doc: 'An argument that controls how crosschecking with both INPUT and SECOND_INPUT
      should occur. Default value: CHECK_SAME_SAMPLE. CHECK_SAME_SAMPLE (In this mode,
      each sample in INPUT will only be checked against a single corresponding sample
      in SECOND_INPUT. If a corresponding sample cannot be found, the program will
      proceed, but report the missing samples and return the value specified in EXIT_CODE_WHEN_MISMATCH.
      The corresponding samples are those that equal each other, after possible renaming
      via INPUT_SAMPLE_MAP and SECOND_INPUT_SAMPLE_MAP. In this mode CROSSCHECK_BY
      must be SAMPLE.) CHECK_ALL_OTHERS (In this mode, each sample in INPUT will be
      checked against all the samples in SECOND_INPUT.)'
  - id: crosscheck_samples
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --CROSSCHECK_SAMPLES
    doc: 'Instead of producing the normal comparison of read-groups, roll fingerprints
      up to the sample level and print out a sample x sample matrix with LOD scores.
      Default value: false. Possible values: {true, false}'
  - id: exit_code_when_mismatch
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --EXIT_CODE_WHEN_MISMATCH
    doc: 'When one or more mismatches between groups is detected, exit with this value
      instead of 0. Default value: 1.'
  - id: exit_code_when_no_valid_checks
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --EXIT_CODE_WHEN_NO_VALID_CHECKS
    doc: 'When all LOD scores are zero, exit with this value. Default value: 1.'
  - id: expect_all_groups_to_match
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --EXPECT_ALL_GROUPS_TO_MATCH
    doc: 'Expect all groups'' fingerprints to match, irrespective of their sample
      names. By default (with this value set to false), groups (readgroups, libraries,
      files, or samples) with different sample names are expected to mismatch, and
      those with the same sample name are expected to match. Default value: false.
      Possible values: {true, false} Cannot be used in conjunction with argument(s)
      EXPECT_ALL_READ_GROUPS_TO_MATCH'
  - id: expect_all_read_groups_to_match
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --EXPECT_ALL_READ_GROUPS_TO_MATCH
    doc: 'Expect all read groups'' fingerprints to match, irrespective of their sample
      names. By default (with this value set to false), read groups with different
      sample names are expected to mismatch, and those with the same sample name are
      expected to match. Default value: false. Possible values: {true, false} Cannot
      be used in conjunction with argument(s) EXPECT_ALL_GROUPS_TO_MATCH'
  - id: genotyping_error_rate
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --GENOTYPING_ERROR_RATE
    doc: 'This argument is DEPRECATED (No longer used in fingerprint checking. Will
      be removed in a future release.). Assumed genotyping error rate that provides
      a floor on the probability that a genotype comes from the expected sample. Must
      be greater than zero. Default value: 0.01.'
  - id: input_index_map
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --INPUT_INDEX_MAP
    doc: A tsv with two columns and no header which maps the input files to corresponding
      indices; to be used when index files are not located next to input files. First
      column must match the list of inputs.
  - id: input_sample_file_map
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --INPUT_SAMPLE_FILE_MAP
    doc: 'A tsv with two columns representing the sample as it should be used for
      comparisons to SECOND_INPUT (in the first column) and the source file (in INPUT)
      for the fingerprint (in the second column). Need only to include the samples
      that change. Values in column 1 should be unique even in union with the remaining
      unmapped samples. Values in column 2 should be unique in the file. Will error
      if more than one sample is found in a file (multi-sample VCF) pointed to in
      column 2. Should only be used in the presence of SECOND_INPUT. Default value:
      null. Cannot be used in conjunction with argument(s) INPUT_SAMPLE_MAP'
  - id: input_sample_map
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --INPUT_SAMPLE_MAP
    doc: 'A tsv with two columns representing the sample as it appears in the INPUT
      data (in column 1) and the sample as it should be used for comparisons to SECOND_INPUT
      (in the second column). Need only include the samples that change. Values in
      column 1 should be unique. Values in column 2 should be unique even in union
      with the remaining unmapped samples. Should only be used with SECOND_INPUT.
      Default value: null. Cannot be used in conjunction with argument(s) INPUT_SAMPLE_FILE_MAP'
  - id: lod_threshold
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --LOD_THRESHOLD
    doc: 'If any two groups (with the same sample name) match with a LOD score lower
      than the threshold the tool will exit with a non-zero code to indicate error.
      Program will also exit with an error if it finds two groups with different sample
      name that match with a LOD score greater than -LOD_THRESHOLD. LOD score 0 means
      equal likelihood that the groups match vs. come from different individuals,
      negative LOD score -N, mean 10^N time more likely that the groups are from different
      individuals, and +N means 10^N times more likely that the groups are from the
      same individual. Default value: 0.0.'
  - id: loss_of_het_rate
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --LOSS_OF_HET_RATE
    doc: 'The rate at which a heterozygous genotype in a normal sample turns into
      a homozygous (via loss of heterozygosity) in the tumor (model assumes independent
      events, so this needs to be larger than reality). Default value: 0.5.'
  - id: matrix_output
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --MATRIX_OUTPUT
    doc: 'Optional output file to write matrix of LOD scores to. This is less informative
      than the metrics output and only contains Normal-Normal LOD score (i.e. doesn''t
      account for Loss of Heterozygosity). It is however sometimes easier to use visually.
      Default value: null. Cannot be used in conjunction with argument(s) SECOND_INPUT
      (SI)'
  - id: max_effect_of_each_haplotype_block
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --MAX_EFFECT_OF_EACH_HAPLOTYPE_BLOCK
    doc: 'Maximal effect of any single haplotype block on outcome (-log10 of maximal
      likelihood difference between the different values for the three possible genotypes).
      Default value: 3.0.'
  - id: num_threads
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --NUM_THREADS
    doc: 'The number of threads to use to process files and generate fingerprints.
      Default value: 1.'
  - id: output
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --OUTPUT
    doc: Optional output file to write metrics to. Default is to write to stdout.
  - id: output_errors_only
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --OUTPUT_ERRORS_ONLY
    doc: 'If true, then only groups that do not relate to each other as expected will
      have their LODs reported. Default value: false. Possible values: {true, false}'
  - id: reference_sequence
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
    doc: Reference sequence file.
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
  - id: require_index_files
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --REQUIRE_INDEX_FILES
    doc: 'A boolean value to determine whether input files should only be parsed if
      index files are available. Without turning this option on, the tool will need
      to read through the entirety of input files without index files either provided
      via the INPUT_INDEX_MAP or locally accessible relative to the input, which significantly
      increases runtime. If set to true and no index is found for a file, an exception
      will be thrown. This applies for both the INPUT and SECOND_INPUT files. Default
      value: false. Possible values: {true, false}'
  - id: sample_individual_map
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --SAMPLE_INDIVIDUAL_MAP
    doc: A tsv with two columns representing the individual with which each sample
      is associated. The first column is the sample id, and the second column is the
      associated individual id. Values in the first column must be unique. If INPUT_SAMPLE_MAP
      or SECOND_INPUT_SAMPLE_MAP is also specified, then the values in the first column
      of this file should be the sample aliases specified in the second columns of
      INPUT_SAMPLE_MAP and SECOND_INPUT_SAMPLE_MAP, respectively. When this input
      is specified, expectations for matches will be based on the equality or inequality
      of the individual ids associated with two samples, as opposed to the sample
      ids themselves. Samples which are not listed in this file will have their sample
      id used as their individual id, for the purposes of match expectations. This
      means that one sample id could be used as the individual id for another sample,
      but not included in the map itself, and these two samples would be considered
      to have come from the same individual. Note that use of this parameter only
      affects labelling of matches and mismatches as EXPECTED or UNEXPECTED. It has
      no affect on how data is grouped for crosschecking.
  - id: second_input
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --SECOND_INPUT
    inputBinding:
      position: 101
    doc: 'A second set of input files (or lists of files) with which to compare fingerprints.
      If this option is provided the tool compares each sample in INPUT with the sample
      from SECOND_INPUT that has the same sample ID. In addition, data will be grouped
      by SAMPLE regardless of the value of CROSSCHECK_BY. When operating in this mode,
      each sample in INPUT must also have a corresponding sample in SECOND_INPUT.
      If this is violated, the tool will proceed to check the matching samples, but
      report the missing samples and return a non-zero error-code. This argument may
      be specified 0 or more times. Default value: null. Cannot be used in conjunction
      with argument(s) MATRIX_OUTPUT (MO)'
  - id: second_input_index_map
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --SECOND_INPUT_INDEX_MAP
    doc: A tsv with two columns and no header which maps the second input files to
      corresponding indices; to be used when index files are not located next to second
      input files. First column must match the list of second inputs.
  - id: second_input_sample_map
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --SECOND_INPUT_SAMPLE_MAP
    doc: A tsv with two columns representing the sample as it appears in the SECOND_INPUT
      data (in column 1) and the sample as it should be used for comparisons to INPUT
      (in the second column). Note that in case of unrolling files (file-of-filenames)
      one would need to reference the final file, i.e. the file that contains the
      genomic data. Need only include the samples that change. Values in column 1
      should be unique. Values in column 2 should be unique even in union with the
      remaining unmapped samples. Should only be used with SECOND_INPUT.
outputs:
  - id: matrix_output_out
    type:
      - 'null'
      - File
    doc: 'Optional output file to write matrix of LOD scores to. This is less informative
      than the metrics output and only contains Normal-Normal LOD score (i.e. doesn''t
      account for Loss of Heterozygosity). It is however sometimes easier to use visually.
      Default value: null. Cannot be used in conjunction with argument(s) SECOND_INPUT
      (SI)'
    outputBinding:
      glob: $(inputs.matrix_output)
  - id: output_output
    type:
      - 'null'
      - File
    doc: Optional output file to write metrics to. Default is to write to stdout.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
successCodes:
  - 0
  - 4
