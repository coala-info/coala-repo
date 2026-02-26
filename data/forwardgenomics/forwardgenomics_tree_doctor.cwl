cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree_doctor
label: forwardgenomics_tree_doctor
doc: "Scale, prune, merge, and otherwise tweak phylogenetic trees. Expects input to
  be a tree model (.mod) file unless filename ends with '.nh' or -n option is used,
  in which case it will be expected to be a tree file in Newick format.\n\nTool homepage:
  https://github.com/hillerlab/ForwardGenomics"
inputs:
  - id: input_file
    type: File
    doc: Input tree model (.mod) or Newick (.nh) file
    inputBinding:
      position: 1
  - id: branchlen
    type:
      - 'null'
      - boolean
    doc: In place of ordinary output, print the total branch length of the tree 
      that would have been printed.
    inputBinding:
      position: 102
      prefix: --branchlen
  - id: depth
    type:
      - 'null'
      - string
    doc: In place of ordinary output, report distance from named node to root
    inputBinding:
      position: 102
      prefix: --depth
  - id: dissect
    type:
      - 'null'
      - boolean
    doc: In place of ordinary output, print a description of the id, name, 
      parent, children, and distance to parent for each node of the tree. 
      Sometimes useful for debugging. Can be used with other options.
    inputBinding:
      position: 102
      prefix: --dissect
  - id: extrapolate
    type:
      - 'null'
      - string
    doc: Extrapolate to a larger set of species based on the given phylogeny 
      (Newick-format). The primary tree must be a subtree of the phylogeny given
      in <phylog.nh>, but it need not be a "proper" subtree (see --merge). A 
      copy will be created of the larger phylogeny then scaled such that the 
      total branch length of the subtree corresponding to the primary tree 
      equals the total branch length of the primary tree; this new version will 
      then be used in place of the primary tree. If the string "default" is 
      given instead of a filename, then a phylogeny for 25 vertebrate species, 
      estimated from sequence data for Target 1 (CFTR) of the NISC Comparative 
      Sequencing Program (Thomas et al., Nature 424:788-793, 2003), will be 
      assumed. This option is similar to merge but differs in that the branch 
      length proportions of the output tree come completely from the larger tree
      and the smaller tree doesn't have to be a proper subset of the larger 
      tree.
    inputBinding:
      position: 102
      prefix: --extrapolate
  - id: get_subtree
    type:
      - 'null'
      - string
    doc: 'Like --prune, but remove all leaves who are not descendants of node. (Note:
      implies --name-ancestors if given node not explicitly named in input tree)'
    inputBinding:
      position: 102
      prefix: --get-subtree
  - id: label_branches
    type:
      - 'null'
      - type: array
        items: string
    doc: Add a label to the branches listed. Branches are named by the name of 
      the node which descends from that branch. See --label-subtree above for 
      more information.
    inputBinding:
      position: 102
      prefix: --label-branches
  - id: label_subtree
    type:
      - 'null'
      - type: array
        items: string
    doc: Add a label to the subtree of the named node. If the node name is 
      followed by a "+" sign, then the branch leading to that node is included 
      in the subtree. This may be used multiple times to add more than one 
      label, though a single branch may have only one label. --label-subtree and
      --label-branches options are parsed in the order given, so that later uses
      may override earlier ones. Labels are applied *after* all pruning, 
      re-rooting, and re-naming options are applied.
    inputBinding:
      position: 102
      prefix: --label-subtree
  - id: merge
    type:
      - 'null'
      - File
    doc: Merge with another tree model or tree. The primary model (<file.mod>) 
      must have a subset of the species (leaves) in the secondary model 
      (<file2.mod>), and the primary tree must be a proper subtree of the 
      secondary tree (i.e., the subtree of the secondary tree beneath the LCA of
      the species in the primary tree must equal the primary tree in terms of 
      topology and species names). If a full tree model is given for the 
      secondary tree, only the tree will be considered. The merged tree model 
      will have the rate matrix, equilibrium frequencies, and rate distribution 
      of the primary model, but a merged tree that includes all species from 
      both models. The trees will be merged by first scaling the secondary tree 
      such that the subtree corresponding to the primary tree has equal overall 
      length to the primary tree, then combining the primary tree with the 
      non-overlapping portion of the secondary tree. The names of matching 
      species (leaves) must be exactly equal.
    inputBinding:
      position: 102
      prefix: --merge
  - id: name_ancestors
    type:
      - 'null'
      - boolean
    doc: Ensure names are assigned to all ancestral nodes. If a node is unnamed,
      create a name by concatenating the names of a leaf from its left subtree 
      and a leaf from its right subtree.
    inputBinding:
      position: 102
      prefix: --name-ancestors
  - id: newick_input
    type:
      - 'null'
      - boolean
    doc: The input file is in Newick format (necessary if file name does not end
      in .nh)
    inputBinding:
      position: 102
      prefix: --newick
  - id: no_branchlen
    type:
      - 'null'
      - boolean
    doc: (Implies --tree-only). Output only topology in Newick format.
    inputBinding:
      position: 102
      prefix: --no-branchlen
  - id: prune
    type:
      - 'null'
      - string
    doc: Remove all leaves whose names are included in the given list 
      (comma-separated), then remove nodes and combine branches to restore as a 
      complete binary tree (i.e., with each node having zero children or two 
      children). This option is applied *before* all other options.
    inputBinding:
      position: 102
      prefix: --prune
  - id: prune_all_but
    type:
      - 'null'
      - string
    doc: Like --prune, but remove all leaves *except* the ones specified.
    inputBinding:
      position: 102
      prefix: --prune-all-but
  - id: rename
    type:
      - 'null'
      - string
    doc: 'Rename leaves according to the given mapping. The format of <mapping> must
      be: "oldname1 -> newname1 ; oldname2 -> newname2 ; ...". This option is applied
      *after* all other options (i.e., old names will be used for --prune, --merge,
      etc.)'
    inputBinding:
      position: 102
      prefix: --rename
  - id: reroot
    type:
      - 'null'
      - string
    doc: Reroot tree at internal node with specified name.
    inputBinding:
      position: 102
      prefix: --reroot
  - id: scale
    type:
      - 'null'
      - float
    doc: Scale all branches by the specified factor.
    inputBinding:
      position: 102
      prefix: --scale
  - id: subtree
    type:
      - 'null'
      - string
    doc: (for use with --scale) Alter only the branches in the subtree beneath 
      the specified node.
    inputBinding:
      position: 102
      prefix: --subtree
  - id: tree_only
    type:
      - 'null'
      - boolean
    doc: Output tree only in Newick format rather than complete tree model.
    inputBinding:
      position: 102
      prefix: --tree-only
  - id: with_branch
    type:
      - 'null'
      - string
    doc: (For use with --reroot or --subtree) include branch above specified 
      node with subtree beneath it.
    inputBinding:
      position: 102
      prefix: --with-branch
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/forwardgenomics:1.0--hdfd78af_0
stdout: forwardgenomics_tree_doctor.out
