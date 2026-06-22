cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - faiths_pd
label: phykit_faiths_pd
doc: Calculate Faith's phylogenetic diversity (PD) for a community of tips on a 
  phylogeny. Faith's PD is the sum of branch lengths in the minimum subtree that
  connects a set of taxa.
inputs:
  - id: tree
    type: File
    doc: First argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: taxa
    type:
      - 'null'
      - File
    doc: File with one tip label per line defining the community
    inputBinding:
      position: 102
      prefix: --taxa
  - id: exclude_root
    type:
      - 'null'
      - boolean
    doc: Sum only branches of the induced subtree rooted at the community MRCA; 
      by default the path up to the tree root is included
    inputBinding:
      position: 102
      prefix: --exclude-root
  - id: json
    type:
      - 'null'
      - boolean
    doc: Optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_faiths_pd.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
