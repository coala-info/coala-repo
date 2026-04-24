cwlVersion: v1.2
class: CommandLineTool
baseCommand: cctk crisprtree
label: cctk_crisprtree
doc: "Builds a CRISPR array phylogenetic tree.\n\nTool homepage: https://github.com/Alan-Collins/CRISPR_comparison_toolkit"
inputs:
  - id: arrays_to_join
    type:
      - 'null'
      - type: array
        items: string
    doc: IDs of the arrays you want to analyse.
    inputBinding:
      position: 1
  - id: acquisition
    type:
      - 'null'
      - int
    doc: parsimony cost of a spacer acquisition event.
    inputBinding:
      position: 102
      prefix: --acquisition
  - id: array_file
    type: File
    doc: Array_IDs.txt or Array_seqs.txt
    inputBinding:
      position: 102
      prefix: --array-file
  - id: branch_support
    type:
      - 'null'
      - string
    doc: 'Show support. Options: colour, number, newick'
    inputBinding:
      position: 102
      prefix: --branch-support
  - id: brlen_scale
    type:
      - 'null'
      - float
    doc: factor to scale branch length
    inputBinding:
      position: 102
      prefix: --brlen-scale
  - id: colour_file
    type:
      - 'null'
      - File
    doc: file with custom colour list
    inputBinding:
      position: 102
      prefix: --colour-file
  - id: colour_scheme_infile
    type:
      - 'null'
      - File
    doc: input file json format colour scheme
    inputBinding:
      position: 102
      prefix: --colour-scheme-infile
  - id: deletion
    type:
      - 'null'
      - int
    doc: parsimony cost of a deletion event.
    inputBinding:
      position: 102
      prefix: --deletion
  - id: dpi
    type:
      - 'null'
      - int
    doc: resolution of the output image.
    inputBinding:
      position: 102
      prefix: --dpi
  - id: duplication
    type:
      - 'null'
      - int
    doc: parsimony cost of a duplication event.
    inputBinding:
      position: 102
      prefix: --duplication
  - id: fix_order
    type:
      - 'null'
      - boolean
    doc: only build one tree using the provided order of arrays
    inputBinding:
      position: 102
      prefix: --fix-order
  - id: font_override_annotations
    type:
      - 'null'
      - float
    doc: set annotation font size in pts
    inputBinding:
      position: 102
      prefix: --font-override-annotations
  - id: font_override_labels
    type:
      - 'null'
      - float
    doc: set label font size in pts
    inputBinding:
      position: 102
      prefix: --font-override-labels
  - id: force_colour_unique
    type:
      - 'null'
      - boolean
    doc: override black colour of unique spacers. Instead use specified colour 
      scheme
    inputBinding:
      position: 102
      prefix: --force-colour-unique
  - id: include_branch_lengths
    type:
      - 'null'
      - boolean
    doc: include branch lengths in tree plot
    inputBinding:
      position: 102
      prefix: -b
  - id: insertion
    type:
      - 'null'
      - int
    doc: parsimony cost of an insertion event.
    inputBinding:
      position: 102
      prefix: --insertion
  - id: no_align_cartoons
    type:
      - 'null'
      - boolean
    doc: draw array cartoons next to leaf node
    inputBinding:
      position: 102
      prefix: --no-align-cartoons
  - id: no_align_labels
    type:
      - 'null'
      - boolean
    doc: draw leaf labels next to leaf node
    inputBinding:
      position: 102
      prefix: --no-align-labels
  - id: no_emphasize_diffs
    type:
      - 'null'
      - boolean
    doc: don't emphasize events in each array since its ancestor
    inputBinding:
      position: 102
      prefix: --no-emphasize-diffs
  - id: no_fade_anc
    type:
      - 'null'
      - boolean
    doc: do not apply transparency to ancestral array depiction
    inputBinding:
      position: 102
      prefix: --no-fade-anc
  - id: no_ident
    type:
      - 'null'
      - int
    doc: parsimony cost of an array having no identity with its ancestor.
    inputBinding:
      position: 102
      prefix: --no-ident
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads to use.
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: plot_height
    type:
      - 'null'
      - float
    doc: height of plot in inches.
    inputBinding:
      position: 102
      prefix: --plot-height
  - id: plot_width
    type:
      - 'null'
      - float
    doc: width of plot in inches.
    inputBinding:
      position: 102
      prefix: --plot-width
  - id: print_tree
    type:
      - 'null'
      - boolean
    doc: print an ascii symbol representation of the tree
    inputBinding:
      position: 102
      prefix: --print-tree
  - id: rep_indel
    type:
      - 'null'
      - int
    doc: parsimony cost independently acquiring spacers.
    inputBinding:
      position: 102
      prefix: --rep-indel
  - id: replicates
    type:
      - 'null'
      - int
    doc: number of replicates of tree building.
    inputBinding:
      position: 102
      prefix: --replicates
  - id: seed
    type:
      - 'null'
      - int
    doc: set seed for random processes
    inputBinding:
      position: 102
      prefix: --seed
  - id: trailer_loss
    type:
      - 'null'
      - int
    doc: parsimony cost of trailer spacer loss.
    inputBinding:
      position: 102
      prefix: --trailer-loss
outputs:
  - id: out_file
    type: File
    doc: output plot file name and path
    outputBinding:
      glob: $(inputs.out_file)
  - id: output_arrays
    type:
      - 'null'
      - File
    doc: file to store analyzed arrays and hypothetical ancestors
    outputBinding:
      glob: $(inputs.output_arrays)
  - id: colour_scheme_outfile
    type:
      - 'null'
      - File
    doc: output file to store json format colour schemes
    outputBinding:
      glob: $(inputs.colour_scheme_outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
