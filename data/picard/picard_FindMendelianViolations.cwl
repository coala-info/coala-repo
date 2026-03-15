cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - FindMendelianViolations
label: picard_FindMendelianViolations
doc: Takes in VCF or BCF and a pedigree file and looks for high confidence calls
  where the genotype of the offspring is incompatible with the genotypes of the 
  parents.
inputs:
  - id: input
    type: File
    doc: Input VCF or BCF with genotypes.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: Output metrics file.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: trios
    type:
      - 'null'
      - File
    doc: File of Trio information in PED format (with no genotype columns).
    inputBinding:
      position: 101
      prefix: --TRIOS
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
  - id: female_chroms
    type:
      - 'null'
      - type: array
        items: string
    doc: List of possible names for female sex chromosome(s)
    inputBinding:
      position: 101
      prefix: --FEMALE_CHROMS
  - id: male_chroms
    type:
      - 'null'
      - type: array
        items: string
    doc: List of possible names for male sex chromosome(s)
    inputBinding:
      position: 101
      prefix: --MALE_CHROMS
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: min_dp
    type:
      - 'null'
      - int
    doc: Minimum depth in each sample to consider possible mendelian violations.
    inputBinding:
      position: 101
      prefix: --MIN_DP
  - id: min_gq
    type:
      - 'null'
      - int
    doc: Minimum genotyping quality (or non-ref likelihood) to perform tests.
    inputBinding:
      position: 101
      prefix: --MIN_GQ
  - id: min_het_fraction
    type:
      - 'null'
      - float
    doc: Minimum allele balance at sites that are heterozygous in the offspring.
    inputBinding:
      position: 101
      prefix: --MIN_HET_FRACTION
  - id: pseudo_autosomal_regions
    type:
      - 'null'
      - type: array
        items: string
    doc: List of chr:start-end for pseudo-autosomal regions on the female sex 
      chromosome.
    inputBinding:
      position: 101
      prefix: --PSEUDO_AUTOSOMAL_REGIONS
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
  - id: skip_chroms
    type:
      - 'null'
      - type: array
        items: string
    doc: List of chromosome names to skip entirely.
    inputBinding:
      position: 101
      prefix: --SKIP_CHROMS
  - id: tab_mode
    type:
      - 'null'
      - boolean
    doc: If true then fields need to be delimited by a single tab. If false the 
      delimiter is one or more whitespace characters.
    inputBinding:
      position: 101
      prefix: --TAB_MODE
  - id: thread_count
    type:
      - 'null'
      - int
    doc: The number of threads that will be used to collect the metrics.
    inputBinding:
      position: 101
      prefix: --THREAD_COUNT
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
    doc: Validation stringency for all SAM files read by this program.
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: vcf_dir
    type: string
    doc: If provided, output per-family VCFs of mendelian violations into this 
      directory.
    inputBinding:
      position: 101
      prefix: --VCF_DIR
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
    doc: Output metrics file.
    outputBinding:
      glob: $(inputs.output)
  - id: output_vcf_dir
    type:
      - 'null'
      - Directory
    doc: If provided, output per-family VCFs of mendelian violations into this 
      directory.
    outputBinding:
      glob: $(inputs.vcf_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
