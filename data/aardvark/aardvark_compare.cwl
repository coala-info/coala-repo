cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - aardvark
  - compare
label: aardvark_compare
doc: "Core function for measuring a query VCF relative to a truth VCF\n\nTool homepage: https://github.com/PacificBiosciences/aardvark"
inputs:
  - id: compare_label
    type:
      - 'null'
      - string
    doc: Optional comparison label for the summary output
    inputBinding:
      position: 101
      prefix: --compare-label
  - id: disable_variant_trimming
    type:
      - 'null'
      - boolean
    doc: Disables variant trimming, which may have a negative impact on accuracy
    inputBinding:
      position: 101
      prefix: --disable-variant-trimming
  - id: enable_haplotype_metrics
    type:
      - 'null'
      - boolean
    doc: Enables the haplotype scoring metrics
    inputBinding:
      position: 101
      prefix: --enable-haplotype-metrics
  - id: enable_record_basepair_metrics
    type:
      - 'null'
      - boolean
    doc: Enables the record-basepair scoring metrics
    inputBinding:
      position: 101
      prefix: --enable-record-basepair-metrics
  - id: enable_weighted_haplotype_metrics
    type:
      - 'null'
      - boolean
    doc: Enables the weighted haplotype scoring metrics
    inputBinding:
      position: 101
      prefix: --enable-weighted-haplotype-metrics
  - id: max_branch_factor
    type:
      - 'null'
      - int
    doc: Maximum branch factor in the query optimizer; limits work on dense variant regions
    inputBinding:
      position: 101
      prefix: --max-branch-factor
  - id: min_variant_gap
    type:
      - 'null'
      - int
    doc: The minimum gap (bp) between variants to split into separate sub-regions
    inputBinding:
      position: 101
      prefix: --min-variant-gap
  - id: query_sample
    type:
      - 'null'
      - string
    doc: The sample name to use in the query VCF
    inputBinding:
      position: 101
      prefix: --query-sample
  - id: query_vcf
    type: File
    doc: Query variant call file (VCF)
    inputBinding:
      position: 101
      prefix: --query-vcf
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
  - id: reference
    type: File
    doc: Reference FASTA file
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: --reference
  - id: regions
    type: File
    doc: Confidence regions (BED). Listed as optional in the help, but aardvark 0.10.4 stops with 'High confidence regions are currently required' without it.
    inputBinding:
      position: 101
      prefix: --regions
  - id: stratification
    type:
      - 'null'
      - File
    doc: Stratifications, specifically the root file-of-filenames TSV
    inputBinding:
      position: 101
      prefix: --stratification
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use in the benchmarking step
    inputBinding:
      position: 101
      prefix: --threads
  - id: truth_sample
    type:
      - 'null'
      - string
    doc: The sample name to use in the truth VCF
    inputBinding:
      position: 101
      prefix: --truth-sample
  - id: truth_vcf
    type: File
    doc: Truth variant call file (VCF)
    inputBinding:
      position: 101
      prefix: --truth-vcf
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_debug_path
    type:
      - 'null'
      - string
    doc: Optional output debug folder
    inputBinding:
      position: 102
      prefix: --output-debug
  - id: output_dir_path
    type: string
    doc: Output directory containing summary and VCFs
    inputBinding:
      position: 103
      prefix: --output-dir
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory containing summary and VCFs
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: output_debug
    type:
      - 'null'
      - Directory
    doc: Optional output debug folder
    outputBinding:
      glob: $(inputs.output_debug_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aardvark:0.10.4--h4349ce8_0
