cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree2ps
label: gb_taxonomy_tools_tree2ps
doc: "Converts a Newick tree file to a PostScript file.\n\nTool homepage: https://github.com/spond/gb_taxonomy_tools"
inputs:
  - id: newick_file
    type: File
    doc: Input Newick tree file
    inputBinding:
      position: 1
  - id: max_taxonomic_depth
    type: int
    doc: Maximum taxonomic depth (<=0 to show all levels)
    inputBinding:
      position: 2
  - id: font_size
    type: int
    doc: Font size (in 2-255, 8 is a good default)
    inputBinding:
      position: 3
  - id: nmax_leaves
    type: int
    doc: Maximum number of leaves to show (<=0 to show all)
    inputBinding:
      position: 4
  - id: count_duplicate_tax_id
    type: boolean
    doc: Count duplicate tax IDs (0 or 1; with 0 multiple copies of the same 
      taxid count as 1)
    inputBinding:
      position: 5
outputs:
  - id: postscript_output_file
    type: File
    doc: PostScript output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
