cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp-pileup
label: snp-pileup
doc: "Generate a CSV file of read counts for SNP positions from BAM files, typically
  used as input for the FACETS copy number analysis tool.\n\nTool homepage: https://github.com/mskcc/facets"
inputs:
  - id: vcf_file
    type: File
    doc: VCF file containing SNP positions.
    inputBinding:
      position: 1
  - id: bam_files
    type:
      type: array
      items: File
    doc: One or more BAM files to process.
    inputBinding:
      position: 2
  - id: count_orphans
    type:
      - 'null'
      - boolean
    doc: Do not discard anomalous read pairs.
    inputBinding:
      position: 103
      prefix: --count-orphans
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Gzip output file.
    inputBinding:
      position: 103
      prefix: --gzip
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file.
    inputBinding:
      position: 103
      prefix: --log-file
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum depth.
    default: 4000
    inputBinding:
      position: 103
      prefix: --max-depth
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality.
    default: 0
    inputBinding:
      position: 103
      prefix: --min-base-quality
  - id: min_map_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality.
    default: 0
    inputBinding:
      position: 103
      prefix: --min-map-quality
  - id: min_read_counts
    type:
      - 'null'
      - string
    doc: Comma separated list of minimum read counts for each bam file.
    inputBinding:
      position: 103
      prefix: --min-read-counts
  - id: pseudo_snps
    type:
      - 'null'
      - boolean
    doc: Use all positions in VCF, not just SNPs.
    inputBinding:
      position: 103
      prefix: --pseudo-snps
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output CSV file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp-pileup:0.6.2--h503566f_8
