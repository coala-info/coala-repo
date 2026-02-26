cwlVersion: v1.2
class: CommandLineTool
baseCommand: clusterfunk
label: clusterfunk_Assigns
doc: "A tool for manipulating and annotating phylogenetic trees.\n\nTool homepage:
  https://github.com/cov-ert/clusterfunk"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to execute. Valid choices include: phylotype, phylotype_dat_tree,
      annotate_tips, annotate_dat_tips, ancestral_reconstruction, annotate_tips_from_nodes,
      extract_tip_annotations, extract_dat_tree, get_taxa, get_dat_taxa, label_transitions,
      label_dat_transition, prune, prune_dat_tree, graft, graft_dat_tree.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
stdout: clusterfunk_Assigns.out
