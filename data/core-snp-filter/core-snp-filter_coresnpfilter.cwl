cwlVersion: v1.2
class: CommandLineTool
baseCommand: coresnpfilter
label: core-snp-filter_coresnpfilter
doc: "Core-SNP-filter: Filter alignments based on core genome threshold and invariant
  sites.\n\nTool homepage: https://github.com/rrwick/Core-SNP-filter"
inputs:
  - id: input
    type: File
    doc: Input alignment
    inputBinding:
      position: 1
  - id: core
    type:
      - 'null'
      - float
    doc: Restrict to core genome (0.0 to 1.0, default = 0.0)
    inputBinding:
      position: 102
      prefix: --core
  - id: exclude_invariant
    type:
      - 'null'
      - boolean
    doc: Exclude invariant sites
    inputBinding:
      position: 102
      prefix: --exclude_invariant
  - id: invariant_counts
    type:
      - 'null'
      - boolean
    doc: Output invariant site counts (suitable for IQ-TREE -fconst) and nothing
      else
    inputBinding:
      position: 103
      prefix: --invariant_counts
  - id: table_path
    type:
      - 'null'
      - string
    doc: Create a table with per-site information
    inputBinding:
      position: 104
      prefix: --table
outputs:
  - id: filtered_alignment
    type: stdout
    doc: Filtered alignment (FASTA) written to stdout; with --invariant_counts,
      the invariant site counts instead
  - id: table
    type:
      - 'null'
      - File
    doc: Create a table with per-site information
    outputBinding:
      glob: $(inputs.table_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/core-snp-filter:0.2.0--h3ab6199_2
stdout: coresnpfilter.out
