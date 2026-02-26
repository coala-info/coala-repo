cwlVersion: v1.2
class: CommandLineTool
baseCommand: phybin
label: phybin
doc: "A tool for binning phylogenetic trees by topology using Robinson-Foulds distance.\n\
  \nTool homepage: https://github.com/rrnewton/PhyBin"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input phylogenetic tree files (Newick format)
    inputBinding:
      position: 1
  - id: bin
    type:
      - 'null'
      - boolean
    doc: Cluster trees into bins based on topology
    inputBinding:
      position: 102
      prefix: --bin
  - id: dist
    type:
      - 'null'
      - boolean
    doc: Calculate all-to-all Robinson-Foulds distance matrix
    inputBinding:
      position: 102
      prefix: --dist
  - id: graph
    type:
      - 'null'
      - boolean
    doc: Generate Graphviz (.dot) files for the bins
    inputBinding:
      position: 102
      prefix: --graph
  - id: max_dist
    type:
      - 'null'
      - float
    doc: Maximum Robinson-Foulds distance allowed within a bin
    inputBinding:
      position: 102
      prefix: --max-dist
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum number of trees in a bin to be reported
    inputBinding:
      position: 102
      prefix: --min-size
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write output files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/phybin:v0.3-3-deb_cv1
