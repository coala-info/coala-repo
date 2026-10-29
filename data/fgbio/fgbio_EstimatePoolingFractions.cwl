cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_EstimatePoolingFractions
doc: "Examines sequence data generated from a pooled sample and estimates the fraction\
  \ of sequence data coming from each\nconstituent sample. Uses a VCF of known genotypes\
  \ for the samples within the mixture along with a BAM of sequencing\ndata derived\
  \ from the pool. Performs a multiple regression for the alternative allele fractions\
  \ at each SNP locus,\nusing as inputs the individual sample's genotypes. Only SNPs\
  \ that are bi-allelic within the pooled samples are used.\n\nEach sample's contribution\
  \ of REF vs. ALT alleles at each site is derived in one of two ways: (1) if the\
  \ sample's\ngenotype in the VCF has the 'AF' attribute then the value from that\
  \ field will be used, (2) if the genotype has no 'AF'\nattribute then the contribution\
  \ is estimated based on the genotype (e.g. 0/0 will be 100% ref, 0/1 will be 50%\
  \ ref and\n50% alt, etc.).\n\nVarious filtering parameters can be used to control\
  \ which loci are used:\n\n  * --intervals will restrict analysis to variants within\
  \ the described intervals\n  * --min-genotype-quality will filter out any site with\
  \ any genotype with GQ < n\n  * --min-mean-sample-coverage requires that the coverage\
  \ of a site in the BAM be >= 'min-mean-sample-coverage *\n    n_samples'\n  * --min-mapping-quality\
  \ filters out reads in the BAM with MQ < n\n  * --min-base-quality filters out bases\
  \ in the BAM with Q < n\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
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
  - id: input_bam
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    type: File
    doc: Path to BAM file of sequencing data.
    inputBinding:
      position: 101
      prefix: --bam
  - id: input_vcf
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
    type: File
    doc: VCF of individual sample genotypes.
    inputBinding:
      position: 101
      prefix: --vcf
  - id: intervals
    type:
      - 'null'
      - File[]
    doc: Zero or more set of regions to restrict analysis to.
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
    doc: 'Minimum base quality. [Default: 5].'
    inputBinding:
      position: 101
      prefix: --min-base-quality
  - id: min_genotype_quality
    type:
      - 'null'
      - int
    doc: 'Minimum genotype quality. Use -1 to disable. [Default: 30].'
    inputBinding:
      position: 101
      prefix: --min-genotype-quality
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: 'Minimum mapping quality. [Default: 20].'
    inputBinding:
      position: 101
      prefix: --min-mapping-quality
  - id: min_mean_sample_coverage
    type:
      - 'null'
      - int
    doc: 'Minimum (sequencing coverage @ SNP site / n_samples). [Default: 6].'
    inputBinding:
      position: 101
      prefix: --min-mean-sample-coverage
  - id: non_autosomes
    type:
      - 'null'
      - string[]
    doc: 'Non-autosomal chromosomes to avoid. [Default: M, chrM, MT, X, chrX, Y, chrY].'
    inputBinding:
      position: 101
      prefix: --non-autosomes
  - id: output_file
    type: string
    doc: Output file to write with pooling fractions.
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
  - id: samples
    type:
      - 'null'
      - string[]
    doc: Optional subset of samples from VCF to use.
    inputBinding:
      position: 101
      prefix: --samples
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
arguments:
  - position: 50
    valueFrom: EstimatePoolingFractions
outputs:
  - id: output_file_out
    type: File
    doc: File with the estimated pooling fractions.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
