cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - GenotypeConcordance
label: picard_GenotypeConcordance
doc: "Calculates the concordance between genotype data of one sample in each of two
  VCFs - truth (or reference) vs. calls. The concordance is broken into separate results
  sections for SNPs and indels. Summary and detailed statistics are reported.\n\n\
  Tool homepage: http://broadinstitute.github.io/picard/"
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
  - id: call_sample
    type:
      - 'null'
      - string
    doc: The name of the call sample within the call VCF. Not required if only 
      one sample exists.
    inputBinding:
      position: 101
      prefix: --CALL_SAMPLE
  - id: call_vcf
    type: File
    doc: The VCF containing the call sample
    inputBinding:
      position: 101
      prefix: --CALL_VCF
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
  - id: ignore_filter_status
    type:
      - 'null'
      - boolean
    doc: Default is false. If true, filter status of sites will be ignored so 
      that we include filtered sites when calculating genotype concordance.
    default: false
    inputBinding:
      position: 101
      prefix: --IGNORE_FILTER_STATUS
  - id: intersect_intervals
    type:
      - 'null'
      - boolean
    doc: If true, multiple interval lists will be intersected. If false multiple
      lists will be unioned.
    default: true
    inputBinding:
      position: 101
      prefix: --INTERSECT_INTERVALS
  - id: intervals
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more interval list files that will be used to limit the genotype
      concordance. Note - if intervals are specified, the VCF files must be 
      indexed.
    inputBinding:
      position: 101
      prefix: --INTERVALS
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
  - id: min_dp
    type:
      - 'null'
      - int
    doc: Genotypes below this depth will have genotypes classified as LowDp.
    default: 0
    inputBinding:
      position: 101
      prefix: --MIN_DP
  - id: min_gq
    type:
      - 'null'
      - int
    doc: Genotypes below this genotype quality will have genotypes classified as
      LowGq.
    default: 0
    inputBinding:
      position: 101
      prefix: --MIN_GQ
  - id: missing_sites_hom_ref
    type:
      - 'null'
      - boolean
    doc: Default is false, which follows the GA4GH Scheme. If true, missing 
      sites in the truth set will be treated as HOM_REF sites and sites missing 
      in both the truth and call sets will be true negatives.
    default: false
    inputBinding:
      position: 101
      prefix: --MISSING_SITES_HOM_REF
  - id: output_all_rows
    type:
      - 'null'
      - boolean
    doc: If true, output all rows in detailed statistics even when count == 0. 
      When false only output rows with non-zero counts.
    default: false
    inputBinding:
      position: 101
      prefix: --OUTPUT_ALL_ROWS
  - id: output_vcf
    type:
      - 'null'
      - boolean
    doc: Output a VCF annotated with concordance information.
    default: false
    inputBinding:
      position: 101
      prefix: --OUTPUT_VCF
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
  - id: truth_sample
    type:
      - 'null'
      - string
    doc: The name of the truth sample within the truth VCF. Not required if only
      one sample exists.
    inputBinding:
      position: 101
      prefix: --TRUTH_SAMPLE
  - id: truth_vcf
    type: File
    doc: The VCF containing the truth sample
    inputBinding:
      position: 101
      prefix: --TRUTH_VCF
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
  - id: use_vcf_index
    type:
      - 'null'
      - boolean
    doc: If true, use the VCF index, else iterate over the entire VCF.
    default: false
    inputBinding:
      position: 101
      prefix: --USE_VCF_INDEX
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
    doc: Basename for the three metrics files that are to be written. Resulting 
      files will be <OUTPUT>.genotype_concordance_summary_metrics, 
      <OUTPUT>.genotype_concordance_detail_metrics, and 
      <OUTPUT>.genotype_concordance_contingency_metrics.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
