cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiptv
label: shiptv
doc: "create an HTML tree visualization with optional metadata highlighting\n\nTool
  homepage: https://github.com/peterk87/shiptv"
inputs:
  - id: collapse_support
    type:
      - 'null'
      - float
    doc: Collapse internal branches below specified bootstrap support value 
      (default -1 for no collapsing)
    inputBinding:
      position: 101
      prefix: --collapse-support
  - id: fix_metadata
    type:
      - 'null'
      - boolean
    doc: Try to automatically fix metadata from reference Genbank file.
    inputBinding:
      position: 101
      prefix: --fix-metadata
  - id: genbank_metadata_fields
    type:
      - 'null'
      - File
    doc: Optional fields to extract from Genbank source metadata. One field per 
      line.
    inputBinding:
      position: 101
      prefix: --genbank-metadata-fields
  - id: highlight_user_samples
    type:
      - 'null'
      - boolean
    doc: Highlight user samples with metadata field in tree.
    inputBinding:
      position: 101
      prefix: --highlight-user-samples
  - id: leaflist
    type:
      - 'null'
      - File
    doc: Optional leaf names to select from phylogenetic tree for pruned tree 
      visualization. One leaf name per line.
    inputBinding:
      position: 101
      prefix: --leaflist
  - id: metadata
    type:
      - 'null'
      - File
    doc: Optional tab-delimited metadata for user samples to join with metadata 
      derived from reference genome sequences Genbank file. Sample IDs must be 
      in the first column.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: metadata_fields_in_order
    type:
      - 'null'
      - File
    doc: Optional list of fields in order to output in metadata table and HTML 
      tree visualization. One field per line.
    inputBinding:
      position: 101
      prefix: --metadata-fields-in-order
  - id: midpoint_root
    type:
      - 'null'
      - boolean
    doc: Set midpoint root
    inputBinding:
      position: 101
      prefix: --midpoint-root
  - id: newick_file
    type: File
    doc: Phylogenetic tree Newick file
    inputBinding:
      position: 101
      prefix: --newick
  - id: no_fix_metadata
    type:
      - 'null'
      - boolean
    doc: Try to automatically fix metadata from reference Genbank file.
    inputBinding:
      position: 101
      prefix: --no-fix-metadata
  - id: no_highlight_user_samples
    type:
      - 'null'
      - boolean
    doc: Highlight user samples with metadata field in tree.
    inputBinding:
      position: 101
      prefix: --no-highlight-user-samples
  - id: no_midpoint_root
    type:
      - 'null'
      - boolean
    doc: Set midpoint root
    inputBinding:
      position: 101
      prefix: --no-midpoint-root
  - id: no_verbose
    type:
      - 'null'
      - boolean
    doc: Verbose logs
    inputBinding:
      position: 101
      prefix: --no-verbose
  - id: outgroup
    type:
      - 'null'
      - string
    doc: Tree outgroup taxa
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: output_newick
    type:
      - 'null'
      - File
    doc: Output Newick file
    inputBinding:
      position: 101
      prefix: --output-newick
  - id: ref_genomes_genbank
    type:
      - 'null'
      - File
    doc: Reference genome sequences Genbank file
    inputBinding:
      position: 101
      prefix: --ref-genomes-genbank
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose logs
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_html
    type:
      - 'null'
      - File
    doc: Output HTML tree path
    outputBinding:
      glob: $(inputs.output_html)
  - id: output_metadata_table
    type:
      - 'null'
      - File
    doc: Output metadata table path
    outputBinding:
      glob: $(inputs.output_metadata_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiptv:0.4.1--pyh5e36f6f_0
