cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pbstarphase
  - diplotype
label: pbstarphase_diplotype
doc: "Run the diplotyper on a dataset\n\nTool homepage: https://github.com/PacificBiosciences/pb-StarPhase"
inputs:
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Input alignment file in BAM format, can be specified multiple times; required
      for HLA diplotyping
    inputBinding:
      position: 101
      prefix: --bam
  - id: database
    type: File
    doc: Input database file (JSON)
    inputBinding:
      position: 101
      prefix: --database
  - id: dual_max_ed_delta
    type:
      - 'null'
      - int
    doc: The edit distance delta threshold to stop tracking divergent sequences (efficiency
      heuristic)
    default: 100
    inputBinding:
      position: 101
      prefix: --dual-max-ed-delta
  - id: exclude_set
    type:
      - 'null'
      - File
    doc: Optional file indicating the list of genes to exclude from diplotyping, one
      per line
    inputBinding:
      position: 101
      prefix: --exclude-set
  - id: expected_maf
    type:
      - 'null'
      - float
    doc: Expected minor allele frequency; reduce to account for skew from sequencing
      bias
    default: 0.45
    inputBinding:
      position: 101
      prefix: --expected-maf
  - id: hla_require_dna
    type:
      - 'null'
      - boolean
    doc: Requires HLA alleles to have a DNA sequence definition
    inputBinding:
      position: 101
      prefix: --hla-require-dna
  - id: include_set
    type:
      - 'null'
      - File
    doc: Optional file indicating the list of genes to include in diplotyping, one
      per line
    inputBinding:
      position: 101
      prefix: --include-set
  - id: infer_connections
    type:
      - 'null'
      - boolean
    doc: Enables inferrence of connected alleles based on population observations
    inputBinding:
      position: 101
      prefix: --infer-connections
  - id: max_error_rate
    type:
      - 'null'
      - float
    doc: The maximum error rate for a read to the HLA reference allele
    default: 0.07
    inputBinding:
      position: 101
      prefix: --max-error-rate
  - id: max_sv_length
    type:
      - 'null'
      - int
    doc: The maximum length of an SV to consider, anything longer is ignored
    default: 1000000
    inputBinding:
      position: 101
      prefix: --max-sv-length
  - id: min_cdf_prob
    type:
      - 'null'
      - float
    doc: The minimum cumulative distribution function probability for a heterozygous
      call
    default: 0.001
    inputBinding:
      position: 101
      prefix: --min-cdf-prob
  - id: min_consensus_count
    type:
      - 'null'
      - int
    doc: The minimum counts of sequences required to split into multiple consensuses
    default: 3
    inputBinding:
      position: 101
      prefix: --min-consensus-count
  - id: min_consensus_fraction
    type:
      - 'null'
      - float
    doc: The minimum fraction of sequences required to split into multiple consensuses
      (e.g. MAF)
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min-consensus-fraction
  - id: normalize_d6_only
    type:
      - 'null'
      - boolean
    doc: Disables normalizing coverage with D7 and hybrid alleles
    inputBinding:
      position: 101
      prefix: --normalize-d6-only
  - id: reference
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: sample_name
    type:
      - 'null'
      - string
    doc: 'Sample name from the input VCFs (default: first sample)'
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: sv_vcf
    type:
      - 'null'
      - File
    doc: Input structural variant file in VCF format
    inputBinding:
      position: 101
      prefix: --sv-vcf
  - id: vcf
    type:
      - 'null'
      - File
    doc: Input variant file in VCF format
    inputBinding:
      position: 101
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_calls
    type: File
    doc: Output diplotype call file (JSON)
    outputBinding:
      glob: $(inputs.output_calls)
  - id: pharmcat_tsv
    type:
      - 'null'
      - File
    doc: Output file that can be provided to PharmCAT for further call interpretation
    outputBinding:
      glob: $(inputs.pharmcat_tsv)
  - id: output_debug
    type:
      - 'null'
      - Directory
    doc: Optional output debug folder
    outputBinding:
      glob: $(inputs.output_debug)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbstarphase:2.0.1--h9ee0642_0
