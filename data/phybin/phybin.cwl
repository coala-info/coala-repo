cwlVersion: v1.2
class: CommandLineTool
baseCommand: phybin
label: phybin
doc: "PhyBin bins and clusters Newick trees by topology, using Robinson-Foulds
  distance.\n\nTool homepage: https://github.com/rrnewton/PhyBin"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Newick tree files (paths of Newick files, or directories of them)
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'print WARNINGS and other information (recommended at first)'
    inputBinding:
      position: 102
      prefix: --verbose
  - id: output_dir
    type:
      - 'null'
      - string
    doc: 'set directory to contain all output files (default "./phybin_out/")'
    inputBinding:
      position: 102
      prefix: --output=
      separate: false
  - id: bin
    type:
      - 'null'
      - boolean
    doc: 'Use simple binning, the cheapest form of ''clustering'''
    inputBinding:
      position: 102
      prefix: --bin
  - id: single
    type:
      - 'null'
      - boolean
    doc: 'Use single-linkage clustering (nearest neighbor)'
    inputBinding:
      position: 102
      prefix: --single
  - id: complete
    type:
      - 'null'
      - boolean
    doc: 'Use complete-linkage clustering (furthest neighbor)'
    inputBinding:
      position: 102
      prefix: --complete
  - id: upgma
    type:
      - 'null'
      - boolean
    doc: 'Use Unweighted Pair Group Method (average linkage) - DEFAULT mode'
    inputBinding:
      position: 102
      prefix: --UPGMA
  - id: editdist
    type:
      - 'null'
      - int
    doc: 'Combine all clusters separated by DIST or less. Report a flat list of clusters. Irrespective of whether this is activated, a hierarchical clustering (dendogram.pdf) is produced.'
    inputBinding:
      position: 102
      prefix: --editdist=
      separate: false
  - id: hashrf
    type:
      - 'null'
      - boolean
    doc: '(default) use a variant of the HashRF algorithm for the distance matrix'
    inputBinding:
      position: 102
      prefix: --hashrf
  - id: tolerant
    type:
      - 'null'
      - boolean
    doc: 'use a slower, modified RF metric that tolerates missing taxa'
    inputBinding:
      position: 102
      prefix: --tolerant
  - id: graphbins
    type:
      - 'null'
      - boolean
    doc: 'use graphviz to produce .dot and .pdf output files'
    inputBinding:
      position: 102
      prefix: --graphbins
  - id: showtrees
    type:
      - 'null'
      - boolean
    doc: 'Print (textual) tree topology inside the nodes of the dendrogram'
    inputBinding:
      position: 102
      prefix: --showtrees
  - id: highlight
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --highlight=
          separate: false
    doc: 'Highlight nodes in the tree-of-trees (dendrogram) consistent with the given tree file. Multiple highlights are permitted and use different colors.'
  - id: interior
    type:
      - 'null'
      - boolean
    doc: 'Show the consensus trees for interior nodes in the dendogram, rather than just points.'
    inputBinding:
      position: 102
      prefix: --interior
  - id: prune
    type:
      - 'null'
      - string
    doc: 'Prune trees to only TAXA before doing anything else. Space and comma separated lists of taxa are allowed. Use quotes.'
    inputBinding:
      position: 102
      prefix: --prune=
      separate: false
  - id: minbranchlen
    type:
      - 'null'
      - float
    doc: 'collapse branches less than LEN'
    inputBinding:
      position: 102
      prefix: --minbranchlen=
      separate: false
  - id: minbootstrap
    type:
      - 'null'
      - int
    doc: 'collapse branches with bootstrap values less than INT'
    inputBinding:
      position: 102
      prefix: --minbootstrap=
      separate: false
  - id: nameprefix
    type:
      - 'null'
      - int
    doc: 'Leaf names in the input Newick trees can be gene names, not taxa. Then it is typical to extract taxa names from genes. This option extracts a prefix of NUM characters to serve as the taxa name.'
    inputBinding:
      position: 102
      prefix: --nameprefix=
      separate: false
  - id: namesep
    type:
      - 'null'
      - string
    doc: 'An alternative to --nameprefix, STR provides a set of delimeter characters, for example ''-'' or ''0123456789''. The taxa name is then a variable-length prefix of each gene name up to but not including any character in STR.'
    inputBinding:
      position: 102
      prefix: --namesep=
      separate: false
  - id: namemap
    type:
      - 'null'
      - File
    doc: 'Even once prefixes are extracted it may be necessary to use a lookup table to compute taxa names, e.g. if multiple genes/plasmids map onto one taxa. This option specifies a text file with find/replace entries of the form "<string> <taxaname>", which are applied AFTER -s and -p.'
    inputBinding:
      position: 102
      prefix: --namemap=
      separate: false
  - id: rfdist
    type:
      - 'null'
      - boolean
    doc: 'print a Robinson Foulds distance matrix for the input trees'
    inputBinding:
      position: 102
      prefix: --rfdist
  - id: setdiff
    type:
      - 'null'
      - boolean
    doc: 'for convenience, print the set difference between cluster*.txt files'
    inputBinding:
      position: 102
      prefix: --setdiff
  - id: print
    type:
      - 'null'
      - boolean
    doc: 'simply print out a concise form of each input tree'
    inputBinding:
      position: 102
      prefix: --print
  - id: printnorms
    type:
      - 'null'
      - boolean
    doc: 'simply print out a concise and NORMALIZED form of each input tree'
    inputBinding:
      position: 102
      prefix: --printnorms
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: 'print a strict consensus tree for the inputs, then exit'
    inputBinding:
      position: 102
      prefix: --consensus
  - id: matching
    type:
      - 'null'
      - boolean
    doc: 'print a list of tree names that match any --highlight argument'
    inputBinding:
      position: 102
      prefix: --matching
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory containing all output files
    outputBinding:
      glob: $(inputs.output_dir || 'phybin_out')
  - id: stdout
    type: stdout
    doc: Standard output (distance matrix, trees or consensus in the utility modes)
stdout: phybin.out
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/phybin:v0.3-3-deb_cv1
requirements:
  - class: InlineJavascriptRequirement
