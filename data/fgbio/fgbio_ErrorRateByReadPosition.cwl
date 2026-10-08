cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_ErrorRateByReadPosition
doc: "Calculates the error rate by read position on coordinate sorted mapped BAMs.\
  \ The output file contains a row per read (first of pair, second of pair and unpaired),\
  \ per position in read, with the total number of bases observed, the number of errors\
  \ observed, the overall error rate, and the rate of each kind of substitution error.\n\
  \nSubstitution types are collapsed based on the reference or expected base, with\
  \ only six substitution types being reported: 'A>C', 'A>G', 'A>T', 'C>A', 'C>G'\
  \ and 'C>T'. For example, 'T>G' is grouped in with 'A>C'.\n\nAnalysis can be restricted\
  \ to a set of intervals via the '--intervals' option. Genomic positions can be excluded\
  \ from analysis by supplying a set of variants (either known variants in the sample\
  \ or a catalog of known variants such as dbSNP). For data believed to have low error\
  \ rates it is recommended to use both the '--intervals' and '--variants' options\
  \ to restrict analysis to only regions expected to be homozygous reference in the\
  \ data.\n\nThe following are reads / bases are excluded from the analysis:\n\n \
  \ * Unmapped reads\n  * Reads marked as failing vendor quality\n  * Reads marked\
  \ as duplicates (unless '--include-duplicates' is specified)\n  * Secondary and\
  \ supplemental records\n  * Soft-clipped bases in records\n  * Reads with MAPQ <\
  \ '--min-mapping-quality' (default: 20)\n  * Bases with base quality < '--min-base-quality'\
  \ (default: 0)\n  * Bases where either the read base or the reference base is non-ACGT\n\
  \nAn output text file is generated with the extension '.error_rate_by_read_position.txt'\n\
  \nIf R's 'Rscript' utility is on the path and 'ggplot2' is installed in the R distribution\
  \ then a PDF of error rate plots will also be generated with extension '.error_rate_by_read_position.pdf'.\n\
  \nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: collapse
    type:
      - 'null'
      - boolean
    doc: 'Collapse substitution types based on the reference or expected base, with
      only six substitution types being reported: ''A>C'', ''A>G'', ''A>T'', ''C>A'',
      ''C>G'' and ''C>T''.For example, ''T>G'' is grouped in with ''A>C''. Otherwise,
      all possible substitution types will be reported.'
    inputBinding:
      position: 101
      prefix: --collapse
      separate: false
      valueFrom: $("=" + self)
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 1
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 1
      prefix: --cram-ref-fasta
  - id: include_duplicates
    type:
      - 'null'
      - boolean
    doc: Include duplicate reads, otherwise ignore.
    inputBinding:
      position: 101
      prefix: --include-duplicates
  - id: input_bam
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    type: File
    doc: Input BAM file.
    inputBinding:
      position: 101
      prefix: --input
  - id: intervals
    type:
      - 'null'
      - File
    doc: Optional list of intervals to restrict analysis to.
    inputBinding:
      position: 101
      prefix: --intervals
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: The minimum base quality for a base to be included.
    inputBinding:
      position: 101
      prefix: --min-base-quality
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: The minimum mapping quality for a read to be included.
    inputBinding:
      position: 101
      prefix: --min-mapping-quality
  - id: output_prefix
    type: string
    doc: Output metrics prefix (required in this wrapper, because the default is next
      to the read-only input BAM).
    inputBinding:
      position: 101
      prefix: --output
  - id: ref_fasta
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
    type: File
    doc: Reference sequence fasta file.
    inputBinding:
      position: 101
      prefix: --ref
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: variants
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
    type:
      - 'null'
      - File
    doc: Optional file of variant sites to ignore.
    inputBinding:
      position: 101
      prefix: --variants
arguments:
  - position: 50
    valueFrom: ErrorRateByReadPosition
outputs:
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Error rate metrics written with the given output prefix.
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
