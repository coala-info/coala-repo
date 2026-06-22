cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - network_signal
label: phykit_network_signal
doc: Measures phylogenetic signal (Bloomberg's K and/or Pagel's lambda) on a 
  phylogenetic network by incorporating hybrid edges inferred from quartet 
  concordance factors.
inputs:
  - id: tree
    type: File
    doc: a phylogeny file
    inputBinding:
      position: 101
      prefix: --tree
  - id: trait_data
    type:
      - 'null'
      - File
    doc: tab-delimited trait data file
    inputBinding:
      position: 101
      prefix: --trait-data
  - id: hybrid
    type:
      - 'null'
      - type: array
        items: string
    doc: 'hybrid specification: parent hybrid child1 child2 gamma'
    inputBinding:
      position: 101
      prefix: --hybrid
  - id: quartet_json
    type:
      - 'null'
      - File
    doc: path to quartet network JSON output file
    inputBinding:
      position: 101
      prefix: --quartet-json
  - id: method
    type:
      - 'null'
      - string
    doc: 'which signal measure to compute: both, blombergs_k, or lambda'
    inputBinding:
      position: 101
      prefix: --method
  - id: permutations
    type:
      - 'null'
      - int
    doc: number of permutations for significance testing
    inputBinding:
      position: 101
      prefix: --permutations
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
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
stdout: phykit_network_signal.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
