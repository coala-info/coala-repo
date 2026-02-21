cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxbp
label: phyx_pxbp
doc: "Print out bipartitions found in treefile. Trees are assumed rooted unless the
  -e argument is provided. This will take a newick- or nexus-formatted tree from a
  file or STDIN.\n\nTool homepage: https://github.com/FePhyFoFum/phyx"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 101
      prefix: --citation
  - id: cutoff
    type:
      - 'null'
      - float
    doc: skip biparts that have support lower than this.
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: edge_all
    type:
      - 'null'
      - boolean
    doc: force edgewise (not node - so when things are unrooted) and assume all taxa
      are present in all trees
    inputBinding:
      position: 101
      prefix: --edgeall
  - id: map_tree
    type:
      - 'null'
      - File
    doc: put the bipart freq on the edges of this tree. This will create a *.pxbpmapped.tre
      file.
    inputBinding:
      position: 101
      prefix: --maptree
  - id: suppress
    type:
      - 'null'
      - boolean
    doc: don't print all the output (maybe you use this with the maptree feature
    inputBinding:
      position: 101
      prefix: --suppress
  - id: tree_file
    type:
      - 'null'
      - File
    doc: input treefile, STDIN otherwise
    inputBinding:
      position: 101
      prefix: --treef
  - id: unique_tree
    type:
      - 'null'
      - boolean
    doc: output unique trees and *no* other output
    inputBinding:
      position: 101
      prefix: --uniquetree
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: give more output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file, STOUT otherwise
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
