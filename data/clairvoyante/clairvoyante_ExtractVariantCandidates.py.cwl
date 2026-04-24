cwlVersion: v1.2
class: CommandLineTool
baseCommand: clairvoyante_ExtractVariantCandidates.py
label: clairvoyante_ExtractVariantCandidates.py
doc: "Extract variant candidates from a BAM file for Clairvoyante variant calling.\n
  \nTool homepage: https://github.com/aquaskyline/Clairvoyante"
inputs:
  - id: bam_fn
    type: File
    doc: BAM file input
    inputBinding:
      position: 101
      prefix: --bam_fn
  - id: bed_fn
    type:
      - 'null'
      - File
    doc: BED file input defining regions of interest
    inputBinding:
      position: 101
      prefix: --bed_fn
  - id: ctg_name
    type:
      - 'null'
      - string
    doc: The name of sequence in the BAM file
    inputBinding:
      position: 101
      prefix: --ctgName
  - id: fprior
    type:
      - 'null'
      - float
    doc: Prior of a site being a false positive
    inputBinding:
      position: 101
      prefix: --fprior
  - id: min_bq
    type:
      - 'null'
      - int
    doc: Minimum base quality
    inputBinding:
      position: 101
      prefix: --minBQ
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage
    inputBinding:
      position: 101
      prefix: --minCoverage
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 101
      prefix: --minMQ
  - id: ref_fn
    type: File
    doc: Reference file input
    inputBinding:
      position: 101
      prefix: --ref_fn
  - id: sample_name
    type:
      - 'null'
      - string
    doc: The name of the sample
    inputBinding:
      position: 101
      prefix: --sampleName
  - id: samtools
    type:
      - 'null'
      - string
    doc: Path to samtools
    inputBinding:
      position: 101
      prefix: --samtools
  - id: vcf_fn
    type:
      - 'null'
      - File
    doc: VCF file input
    inputBinding:
      position: 101
      prefix: --vcf_fn
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clairvoyante:1.02--0
