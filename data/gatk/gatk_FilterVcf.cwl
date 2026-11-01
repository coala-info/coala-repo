cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- FilterVcf
label: gatk_FilterVcf
doc: 'Applies one or more hard filters to a VCF file to filter out genotypes and variants.


  Tool homepage: https://github.com/broadinstitute/gatk'
inputs:
- id: input
  type: File
  doc: The INPUT VCF or BCF file.
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  inputBinding:
    position: 1
    prefix: --INPUT
- id: output
  type: string
  doc: The output VCF or BCF.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: arguments_file
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --arguments_file
  doc: read one or more arguments files and add them to the command line
  inputBinding:
    position: 1
- id: compression_level
  type:
  - 'null'
  - int
  doc: Compression level for all compressed files created (e.g. BAM and VCF).
  inputBinding:
    position: 1
    prefix: --COMPRESSION_LEVEL
- id: create_index
  type:
  - 'null'
  - string
  doc: Whether to create an index when writing VCF or coordinate sorted BAM output. (true or false)
  inputBinding:
    position: 1
    prefix: --CREATE_INDEX
- id: create_md5_file
  type:
  - 'null'
  - boolean
  doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
  inputBinding:
    position: 1
    prefix: --CREATE_MD5_FILE
- id: javascript_file
  type:
  - 'null'
  - File
  doc: 'Filters a VCF file with a javascript expression interpreted by the java javascript engine. The
    script puts the following variables in the script context: ''variant'' a VariantContext ( https://samtools.github.io/htsjdk/javadoc/htsjdk/htsjdk/variant/variantcontext/VariantContext.html
    ) and ''header'' a VCFHeader ( https://samtools.github.io/htsjdk/javadoc/htsjdk/htsjdk/variant/vcf/VCFHeader.html
    ). Last value of the script should be a boolean to tell whether we should accept or reject the record.'
  inputBinding:
    position: 1
    prefix: --JAVASCRIPT_FILE
- id: max_fs
  type:
  - 'null'
  - double
  doc: The maximum phred scaled fisher strand value before a site will be filtered out.
  inputBinding:
    position: 1
    prefix: --MAX_FS
- id: max_records_in_ram
  type:
  - 'null'
  - int
  doc: When writing files that need to be sorted, this will specify the number of records stored in RAM
    before spilling to disk. Increasing this number reduces the number of file handles needed to sort
    the file, and increases the amount of RAM needed.
  inputBinding:
    position: 1
    prefix: --MAX_RECORDS_IN_RAM
- id: min_ab
  type:
  - 'null'
  - double
  doc: The minimum allele balance acceptable before filtering a site. Allele balance is calculated for
    heterozygotes as the number of bases supporting the least-represented allele over the total number
    of base observations. Different heterozygote genotypes at the same locus are measured independently.
    The locus is filtered if any allele balance is below the limit.
  inputBinding:
    position: 1
    prefix: --MIN_AB
- id: min_dp
  type:
  - 'null'
  - int
  doc: The minimum sequencing depth supporting a genotype before the genotype will be filtered out.
  inputBinding:
    position: 1
    prefix: --MIN_DP
- id: min_gq
  type:
  - 'null'
  - int
  doc: The minimum genotype quality that must be achieved for a sample otherwise the genotype will be
    filtered out.
  inputBinding:
    position: 1
    prefix: --MIN_GQ
- id: min_qd
  type:
  - 'null'
  - double
  doc: The minimum QD value to accept or otherwise filter out the variant.
  inputBinding:
    position: 1
    prefix: --MIN_QD
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Whether to suppress job-summary info on System.err.
  inputBinding:
    position: 1
    prefix: --QUIET
- id: reference_sequence
  type:
  - 'null'
  - File
  doc: Reference sequence file.
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
  inputBinding:
    position: 1
    prefix: --REFERENCE_SEQUENCE
- id: tmp_dir
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --TMP_DIR
  doc: One or more directories with space available to be used by this program for temporary storage of
    working files
  inputBinding:
    position: 1
- id: use_jdk_deflater
  type:
  - 'null'
  - boolean
  doc: Use the JDK Deflater instead of the Intel Deflater for writing compressed output
  inputBinding:
    position: 1
    prefix: --USE_JDK_DEFLATER
- id: use_jdk_inflater
  type:
  - 'null'
  - boolean
  doc: Use the JDK Inflater instead of the Intel Inflater for reading compressed input
  inputBinding:
    position: 1
    prefix: --USE_JDK_INFLATER
- id: validation_stringency
  type:
  - 'null'
  - string
  doc: Validation stringency for all SAM files read by this program. Setting stringency to SILENT can
    improve performance when processing a BAM file in which variable-length data (read, qualities, tags)
    do not otherwise need to be decoded.
  inputBinding:
    position: 1
    prefix: --VALIDATION_STRINGENCY
- id: verbosity
  type:
  - 'null'
  - string
  doc: Control verbosity of logging.
  inputBinding:
    position: 1
    prefix: --VERBOSITY
outputs:
- id: output_file
  type: File
  doc: The output VCF or BCF.
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
