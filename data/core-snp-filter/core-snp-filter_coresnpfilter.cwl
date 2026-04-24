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
outputs:
  - id: table
    type:
      - 'null'
      - File
    doc: Create a table with per-site information
    outputBinding:
      glob: $(inputs.table)
  - id: invariant_counts
    type:
      - 'null'
      - File
    doc: Output invariant site counts (suitable for IQ-TREE -fconst) and nothing else
    outputBinding:
      glob: $(inputs.invariant_counts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/core-snp-filter:0.2.0--h3ab6199_2
