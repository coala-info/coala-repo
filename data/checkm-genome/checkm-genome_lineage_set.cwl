cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - lineage_set
label: checkm-genome_lineage_set
doc: "Infer lineage-specific marker sets for each bin.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: tree_dir
    type: Directory
    doc: 'directory specified during tree command'
    inputBinding:
      position: 1
  - id: marker_file
    type: string
    doc: 'output file describing marker set for each bin'
    inputBinding:
      position: 2
  - id: unique
    type:
      - 'null'
      - int
    doc: 'minimum number of unique phylogenetic markers required to use lineage-
      specific marker set (default: 10)'
    inputBinding:
      position: 101
      prefix: --unique
  - id: multi
    type:
      - 'null'
      - int
    doc: 'maximum number of multi-copy phylogenetic markers before defaulting to
      domain-level marker set (default: 10)'
    inputBinding:
      position: 101
      prefix: --multi
  - id: force_domain
    type:
      - 'null'
      - boolean
    doc: 'use domain-level sets for all bins'
    inputBinding:
      position: 101
      prefix: --force_domain
  - id: no_refinement
    type:
      - 'null'
      - boolean
    doc: 'do not perform lineage-specific marker set refinement'
    inputBinding:
      position: 101
      prefix: --no_refinement
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'suppress console output'
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: 'specify an alternative directory for temporary files'
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: marker_file_out
    type: File
    doc: 'output file describing marker set for each bin'
    outputBinding:
      glob: $(inputs.marker_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
