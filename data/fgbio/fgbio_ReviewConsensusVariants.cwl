cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_ReviewConsensusVariants
doc: "Extracts data to make reviewing of variant calls from consensus reads easier.\
  \ Creates a list of variant sites from the\ninput VCF (SNPs only) or IntervalList\
  \ then extracts all the consensus reads that do not contain a reference allele at\n\
  the the variant sites, and all raw reads that contributed to those consensus reads.\
  \ This will include consensus reads\nthat carry the alternate allele, a third allele,\
  \ a no-call or a spanning deletion at the variant site.\n\nReads are correlated\
  \ between consensus and grouped BAMs using a molecule ID stored in an optional attribute,\
  \ 'MI' by\ndefault. In order to support paired molecule IDs where two or more molecule\
  \ IDs are related (e.g. see the Paired\nassignment strategy in GroupReadsByUmi)\
  \ the molecule ID is truncated at the last '/' if present (e.g. '1/A => 1' and '2\n\
  => 2').\n\nBoth input BAMs must be coordinate sorted and indexed.\n\nA pair of output\
  \ BAMs named '<output>.consensus.bam' and '<output>.grouped.bam' are created with\
  \ the relevant reads\nfrom each input BAM, and a review file '<output>.txt' is created.\
  \ The review file contains details on each variant\nposition along with detailed\
  \ information on each consensus read that supports the variant. If the sample-name\
  \ argument\nis supplied and the input is VCF, genotype information for that sample\
  \ will be retrieved. If the sample-name isn't\nsupplied and the VCF contains only\
  \ a single sample then those genotypes will be used.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
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
  - id: consensus_bam
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    type: File
    doc: BAM file of consensus reads used to call variants.
    inputBinding:
      position: 101
      prefix: --consensus-bam
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 1
      prefix: --cram-ref-fasta
  - id: grouped_bam
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    type: File
    doc: BAM file of grouped raw reads used to build consensuses.
    inputBinding:
      position: 101
      prefix: --grouped-bam
  - id: ignore_ns_in_consensus_reads
    type:
      - 'null'
      - boolean
    doc: 'Ignore N bases in the consensus reads. [Default: false].'
    inputBinding:
      position: 101
      prefix: --ignore-ns-in-consensus-reads
      separate: false
      valueFrom: $("=" + self)
  - id: input_variants
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
    type: File
    doc: Input VCF or IntervalList of variant locations.
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
      position: 1
      prefix: --log-level
  - id: maf
    type:
      - 'null'
      - double
    doc: 'Only output detailed information for variants at maf and below. [Default:
      0.05].'
    inputBinding:
      position: 101
      prefix: --maf
  - id: output_prefix
    type: string
    doc: Basename of output files to create.
    inputBinding:
      position: 101
      prefix: --output
  - id: ref_fasta
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: true
    type: File
    doc: Reference fasta file.
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
  - id: sample
    type:
      - 'null'
      - string
    doc: Name of the sample being reviewed.
    inputBinding:
      position: 101
      prefix: --sample
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
    valueFrom: ReviewConsensusVariants
outputs:
  - id: review_file
    type: File
    doc: Review file with details on each variant position and supporting consensus
      read.
    outputBinding:
      glob: $(inputs.output_prefix).txt
  - id: consensus_bam_out
    type: File
    doc: Consensus reads at the variant sites.
    outputBinding:
      glob: $(inputs.output_prefix).consensus.bam
  - id: grouped_bam_out
    type: File
    doc: Raw reads that contributed to those consensus reads.
    outputBinding:
      glob: $(inputs.output_prefix).grouped.bam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
