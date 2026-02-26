cwlVersion: v1.2
class: CommandLineTool
baseCommand: cctk constrain
label: cctk_constrain
doc: "Control run behaviour and plotting elements for tree analysis.\n\nTool homepage:
  https://github.com/Alan-Collins/CRISPR_comparison_toolkit"
inputs:
  - id: acquisition
    type:
      - 'null'
      - int
    doc: parsimony cost of a spacer acquisition event.
    default: 1
    inputBinding:
      position: 101
      prefix: --acquisition
  - id: array_file
    type: File
    doc: Array_IDs.txt or Array_seqs.txt file
    inputBinding:
      position: 101
      prefix: --array-file
  - id: brlen_scale
    type:
      - 'null'
      - float
    doc: factor to scale branch length.
    inputBinding:
      position: 101
      prefix: --brlen-scale
  - id: colour_file
    type:
      - 'null'
      - File
    doc: file with custom colour list
    inputBinding:
      position: 101
      prefix: --colour-file
  - id: colour_scheme_infile
    type:
      - 'null'
      - File
    doc: input file json format colour scheme
    inputBinding:
      position: 101
      prefix: --colour-scheme-infile
  - id: deletion
    type:
      - 'null'
      - int
    doc: parsimony cost of a deletion event.
    default: 10
    inputBinding:
      position: 101
      prefix: --deletion
  - id: dpi
    type:
      - 'null'
      - int
    doc: resolution of the output image.
    default: 600
    inputBinding:
      position: 101
      prefix: --dpi
  - id: duplication
    type:
      - 'null'
      - int
    doc: parsimony cost of a duplication event.
    default: 1
    inputBinding:
      position: 101
      prefix: --duplication
  - id: font_override_annotations
    type:
      - 'null'
      - float
    doc: set annotation font size in pts
    inputBinding:
      position: 101
      prefix: --font-override-annotations
  - id: font_override_labels
    type:
      - 'null'
      - float
    doc: set label font size in pts
    inputBinding:
      position: 101
      prefix: --font-override-labels
  - id: force_colour_unique
    type:
      - 'null'
      - boolean
    doc: override black colour of unique spacers. Instead use specified colour 
      scheme
    inputBinding:
      position: 101
      prefix: --force-colour-unique
  - id: genome_array_file
    type: File
    doc: file corresponding array ID and genome ID
    inputBinding:
      position: 101
      prefix: --genome-array-file
  - id: include_branch_lengths
    type:
      - 'null'
      - boolean
    doc: include branch lengths in tree plot
    inputBinding:
      position: 101
      prefix: -b
  - id: input_tree
    type: File
    doc: file containing tree in newick format
    inputBinding:
      position: 101
      prefix: --input-tree
  - id: insertion
    type:
      - 'null'
      - int
    doc: parsimony cost of an insertion event.
    default: 30
    inputBinding:
      position: 101
      prefix: --insertion
  - id: no_align_cartoons
    type:
      - 'null'
      - boolean
    doc: draw array cartoons next to leaf node
    inputBinding:
      position: 101
      prefix: --no-align-cartoons
  - id: no_align_labels
    type:
      - 'null'
      - boolean
    doc: draw leaf labels next to leaf node
    inputBinding:
      position: 101
      prefix: --no-align-labels
  - id: no_emphasize_diffs
    type:
      - 'null'
      - boolean
    doc: don't emphasize events in each array since its ancestor
    inputBinding:
      position: 101
      prefix: --no-emphasize-diffs
  - id: no_fade_anc
    type:
      - 'null'
      - boolean
    doc: do not apply transparency to ancestral array depiction
    inputBinding:
      position: 101
      prefix: --no-fade-anc
  - id: no_ident
    type:
      - 'null'
      - int
    doc: parsimony cost of an array having no identity with its ancestor.
    default: 100
    inputBinding:
      position: 101
      prefix: --no-ident
  - id: plot_height
    type:
      - 'null'
      - float
    doc: height of plot in inches.
    default: 3.0
    inputBinding:
      position: 101
      prefix: --plot-height
  - id: plot_width
    type:
      - 'null'
      - float
    doc: width of plot in inches.
    default: 3.0
    inputBinding:
      position: 101
      prefix: --plot-width
  - id: print_tree
    type:
      - 'null'
      - boolean
    doc: print an ascii symbol representation of the tree
    inputBinding:
      position: 101
      prefix: --print-tree
  - id: rep_indel
    type:
      - 'null'
      - int
    doc: parsimony cost independently acquiring spacers.
    default: 50
    inputBinding:
      position: 101
      prefix: --rep-indel
  - id: replace_brlens
    type:
      - 'null'
      - boolean
    doc: replace input tree branch lengths with array parsimony costs
    inputBinding:
      position: 101
      prefix: --replace-brlens
  - id: seed
    type:
      - 'null'
      - int
    doc: set seed for random processes
    inputBinding:
      position: 101
      prefix: --seed
  - id: trailer_loss
    type:
      - 'null'
      - int
    doc: parsimony cost of trailer spacer loss.
    default: 1
    inputBinding:
      position: 101
      prefix: --trailer-loss
  - id: unrooted
    type:
      - 'null'
      - boolean
    doc: input tree is unrooted
    inputBinding:
      position: 101
      prefix: --unrooted
outputs:
  - id: out_plot
    type: File
    doc: output plot file name
    outputBinding:
      glob: $(inputs.out_plot)
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
