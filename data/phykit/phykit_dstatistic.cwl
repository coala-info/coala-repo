cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - dstatistic
label: phykit_dstatistic
doc: Compute Patterson's D-statistic (ABBA-BABA test) for detecting 
  introgression or gene flow. Supports site patterns from an alignment or 
  quartet topologies from gene trees.
inputs:
  - id: alignment
    type: File
    doc: FASTA alignment file (site-pattern mode)
    inputBinding:
      position: 101
      prefix: --alignment
  - id: gene_trees
    type:
      - 'null'
      - File
    doc: gene trees file, one Newick per line (gene-tree mode; trees can have 
      any number of taxa)
    inputBinding:
      position: 101
      prefix: --gene-trees
  - id: p1
    type: string
    doc: taxon name for P1 (sister to P2)
    inputBinding:
      position: 101
      prefix: --p1
  - id: p2
    type: string
    doc: taxon name for P2 (sister to P1; potential recipient of gene flow)
    inputBinding:
      position: 101
      prefix: --p2
  - id: p3
    type: string
    doc: taxon name for P3 (donor lineage)
    inputBinding:
      position: 101
      prefix: --p3
  - id: outgroup
    type: string
    doc: outgroup taxon name
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: block_size
    type:
      - 'null'
      - int
    doc: block size for jackknife estimation of standard error (alignment mode 
      only)
    inputBinding:
      position: 101
      prefix: --block-size
  - id: support
    type:
      - 'null'
      - float
    doc: minimum branch support threshold for gene trees; branches below this 
      value are collapsed (treated as unresolved). Gene-tree mode only.
    inputBinding:
      position: 101
      prefix: --support
  - id: json
    type:
      - 'null'
      - boolean
    doc: output results as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_dstatistic.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
