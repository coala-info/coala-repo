cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - aardvark
  - merge
label: aardvark_merge
doc: "Compares and merges variants from different VCF files\n\nTool homepage: https://github.com/PacificBiosciences/aardvark"
inputs:
  - id: conflict_select
    type:
      - 'null'
      - int
    doc: Sets a VCF index to select to always get selected in the event of conflict
    inputBinding:
      position: 101
      prefix: --conflict-select
  - id: disable_variant_trimming
    type:
      - 'null'
      - boolean
    doc: Disables variant trimming, which may have a negative impact on accuracy
    inputBinding:
      position: 101
      prefix: --disable-variant-trimming
  - id: enable_no_conflict
    type:
      - 'null'
      - boolean
    doc: Enables merging if no conflicts are detected
    inputBinding:
      position: 101
      prefix: --enable-no-conflict
  - id: enable_voting
    type:
      - 'null'
      - boolean
    doc: Enables merging if the majority of inputs agree
    inputBinding:
      position: 101
      prefix: --enable-voting
  - id: input_vcf
    type:
      type: array
      items: File
    doc: Input variant call file (VCF), provided in priority order
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: max_branch_factor
    type:
      - 'null'
      - int
    doc: Maximum branch factor in the query optimizer; limits work on dense variant
      regions
    default: 50
    inputBinding:
      position: 101
      prefix: --max-branch-factor
  - id: merge_strategy
    type:
      - 'null'
      - string
    doc: Selects pre-set merge strategy for inclusion of a variant (exact, no_conflict,
      majority, all)
    inputBinding:
      position: 101
      prefix: --merge-strategy
  - id: min_variant_gap
    type:
      - 'null'
      - int
    doc: The minimum gap (bp) between variants to split into separate sub-regions
    default: 50
    inputBinding:
      position: 101
      prefix: --min-variant-gap
  - id: reference
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: regions
    type:
      - 'null'
      - File
    doc: Regions to perform the merge (BED)
    inputBinding:
      position: 101
      prefix: --regions
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use in the benchmarking step
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf_sample
    type:
      - 'null'
      - string
    doc: The sample name to use in the corresponding VCF
    default: first sample
    inputBinding:
      position: 101
      prefix: --vcf-sample
  - id: vcf_tag
    type:
      - 'null'
      - string
    doc: The annotation tag to use for the corresponding VCF
    default: vcf_#
    inputBinding:
      position: 101
      prefix: --vcf-tag
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
  - id: output_vcfs
    type: Directory
    doc: Output VCF folder
    outputBinding:
      glob: $(inputs.output_vcfs)
  - id: output_summary
    type:
      - 'null'
      - File
    doc: Output summary file (CSV/TSV)
    outputBinding:
      glob: $(inputs.output_summary)
  - id: output_debug
    type:
      - 'null'
      - Directory
    doc: Optional output debug folder
    outputBinding:
      glob: $(inputs.output_debug)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aardvark:0.10.4--h4349ce8_0
