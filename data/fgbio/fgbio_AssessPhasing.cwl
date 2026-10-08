cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_AssessPhasing
doc: 'Assess the accuracy of phasing for a set of variants.


  All phased genotypes should be annotated with the ''PS'' (phase set) ''FORMAT''
  tag, which by convention is the position of the first variant in the phase set (see
  the VCF specification). Furthermore, the alleles of a phased genotype should use
  the ''|'' separator instead of the ''/'' separator, where the latter indicates the
  genotype is unphased.


  The input VCFs are assumed to be single sample: the genotype from the first sample
  is used.


  Only bi-allelic heterozygous SNPs are considered.


  The input known phased variants can be subsetted using the known interval list,
  for example to keep only variants from high-confidence regions.


  If the intervals argument is supplied, only the set of chromosomes specified will
  be analyzed. Note that the full chromosome will be analyzed and start/stop positions
  will be ignored.


  Tool homepage: https://github.com/fulcrumgenomics/fgbio'
inputs:
  - id: allow_missing_fields_in_vcf_header
    type:
      - 'null'
      - boolean
    doc: Allow missing fields in the VCF header.
    inputBinding:
      position: 101
      prefix: --allow-missing-fields-in-vcf-header
      separate: false
      valueFrom: $("=" + self)
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: called_vcf
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
    type: File
    doc: The VCF with called phased variants.
    inputBinding:
      position: 101
      prefix: --called-vcf
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
  - id: debug_vcf
    type:
      - 'null'
      - boolean
    doc: Output a VCF with the called variants annotated by if their phase matches
      the truth
    inputBinding:
      position: 101
      prefix: --debug-vcf
  - id: intervals
    type:
      - 'null'
      - File
    doc: Analyze only the given chromosomes in the interval list. The entire chromosome
      will be analyzed (start and end ignored).
    inputBinding:
      position: 101
      prefix: --intervals
  - id: known_intervals
    type:
      - 'null'
      - File
    doc: The interval list over which known phased variants should be kept.
    inputBinding:
      position: 101
      prefix: --known-intervals
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: modify_blocks
    type:
      - 'null'
      - boolean
    doc: Remove enclosed phased blocks and truncate overlapping blocks.
    inputBinding:
      position: 101
      prefix: --modify-blocks
      separate: false
      valueFrom: $("=" + self)
  - id: output_prefix
    type: string
    doc: The output prefix for all output files.
    inputBinding:
      position: 101
      prefix: --output
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: skip_mismatching_alleles
    type:
      - 'null'
      - boolean
    doc: Skip sites where the truth and call are both called but do not share the
      same alleles.
    inputBinding:
      position: 101
      prefix: --skip-mismatching-alleles
      separate: false
      valueFrom: $("=" + self)
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: truth_vcf
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
    type: File
    doc: The VCF with known phased variants.
    inputBinding:
      position: 101
      prefix: --truth-vcf
arguments:
  - position: 50
    valueFrom: AssessPhasing
outputs:
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: The output prefix for all output files.
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
