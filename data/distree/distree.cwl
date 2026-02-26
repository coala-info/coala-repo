cwlVersion: v1.2
class: CommandLineTool
baseCommand: distree
label: distree
doc: "Extracts a distance matrix from a phylogeny (parallel, low-memory)\n\nTool homepage:
  https://github.com/PathoGenOmics-Lab/distree"
inputs:
  - id: phylogeny
    type: File
    doc: Path to the tree file in Newick format
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Tree file format (only 'newick' is supported)
    default: newick
    inputBinding:
      position: 102
      prefix: --format
  - id: lmm
    type:
      - 'null'
      - boolean
    doc: Produce the var-covar matrix C (depth of the MRCA in branch lengths)
    inputBinding:
      position: 102
      prefix: --lmm
  - id: midpoint
    type:
      - 'null'
      - boolean
    doc: Midpoint-root the tree before computing distances
    inputBinding:
      position: 102
      prefix: --midpoint
  - id: topology
    type:
      - 'null'
      - boolean
    doc: Ignore branch lengths; use purely topological distances
    inputBinding:
      position: 102
      prefix: --topology
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to write the TSV output file (defaults to stdout)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/distree:1.0.0--h4349ce8_0
