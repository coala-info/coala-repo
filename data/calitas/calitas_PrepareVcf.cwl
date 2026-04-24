cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - calitas
  - PrepareVcf
label: calitas_PrepareVcf
doc: "Prepares a VCF for optimal use by SearchReference. Does the following:\n\n \
  \ * Removes variants and alleles below an allele frequency threshold\n  * Remove
  all INFO fields except for allele-frequency\n  * Removes any genotypes that are
  present\n  * Optionally fixes up the contig lines in the VCF\n  * Optionally adds
  'chr' prefixes to chromosome names 1-22, X and Y\n\nMultiple input VCFs can be given
  but they must be disjoint (i.e. not have variants over the same regions of the\n\
  genome), and wil be merged to create a single output VCF.\n\nTool homepage: https://github.com/editasmedicine/calitas"
inputs:
  - id: add_chr_prefix
    type:
      - 'null'
      - boolean
    doc: If true, add 'chr' to chroms 1-22, X and Y.
    inputBinding:
      position: 101
      prefix: --add-chr-prefix
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 101
      prefix: --async-io
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 101
      prefix: --compression
  - id: dict
    type:
      - 'null'
      - File
    doc: An optional sequence dictionary to use to override contig lines.
    inputBinding:
      position: 101
      prefix: --dict
  - id: input_vcf
    type:
      type: array
      items: File
    doc: One or more input VCFs
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: min_af
    type:
      - 'null'
      - float
    doc: The minimum allele frequency of variants to retain.
    inputBinding:
      position: 101
      prefix: --min-af
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: output_vcf
    type: File
    doc: The output VCF to create.
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calitas:1.0--hdfd78af_1
