cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit_skim
label: nwkit_skim
doc: "Prunes a newick tree based on trait data.\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
  - id: filter_by
    type:
      - 'null'
      - string
    doc: Column name in the trait table used to rank leaves within each group 
      before sampling. If not specified, leaves are randomly sampled within each
      group.
    default: None
    inputBinding:
      position: 101
      prefix: --filter_by
  - id: filter_mode
    type:
      - 'null'
      - string
    doc: Sorting order for --filter_by values. If multiple leaves within a group
      have the same value, they are randomly sampled.
    default: ascending
    inputBinding:
      position: 101
      prefix: --filter_mode
  - id: format
    type:
      - 'null'
      - int
    doc: ETE tree format. See here 
      http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html
    default: auto
    inputBinding:
      position: 101
      prefix: --format
  - id: group_by
    type:
      - 'null'
      - string
    doc: Column name in the trait table used to group leaves before sampling. 
      Leaves in a clade are treated as a group if all non-missing values in the 
      specified column are identical. If not specified, all leaves are treated 
      as a single group.
    default: None
    inputBinding:
      position: 101
      prefix: --group_by
  - id: infile
    type:
      - 'null'
      - File
    doc: Input newick file. Use "-" for STDIN.
    default: '-'
    inputBinding:
      position: 101
      prefix: --infile
  - id: only_contrastive_clades
    type:
      - 'null'
      - string
    doc: Whether to output a pruned tree retaining only minimal clades with 
      multiple non-missing trait values.
    default: no
    inputBinding:
      position: 101
      prefix: --only_contrastive_clades
  - id: outformat
    type:
      - 'null'
      - int
    doc: ETE tree format for --outfile. "auto" indicates the same format as 
      --format.
    inputBinding:
      position: 101
      prefix: --outformat
  - id: output_groupfile
    type:
      - 'null'
      - string
    doc: Whether to output group assignment files. The output filenames are 
      <output>.all.tsv and <output>.sampled.tsv, where <output> is the value of 
      --outfile without the .nwk extension.
    default: no
    inputBinding:
      position: 101
      prefix: --output_groupfile
  - id: prioritize_non_missing
    type:
      - 'null'
      - string
    doc: Whether to prioritize leaves with non-missing trait values when 
      sampling.
    default: yes
    inputBinding:
      position: 101
      prefix: --prioritize_non_missing
  - id: quoted_node_names
    type:
      - 'null'
      - string
    doc: Whether node names are quoted in the input file.
    default: yes
    inputBinding:
      position: 101
      prefix: --quoted_node_names
  - id: retain_per_clade
    type:
      - 'null'
      - int
    doc: 'Number of leaves to retain per clade (group) (default: 1). If a clade (group)
      contains fewer leaves than this value, all of its leaves are retained.'
    default: 1
    inputBinding:
      position: 101
      prefix: --retain_per_clade
  - id: trait
    type:
      - 'null'
      - File
    doc: Path to a trait table (TSV) containing leaf names in the "leaf_name" 
      column and one or more trait columns. If not specified, all leaves are 
      treated as a single group and randomly sampled.
    default: None
    inputBinding:
      position: 101
      prefix: --trait
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output newick file. Use "-" for STDOUT.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
