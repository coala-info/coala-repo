cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - lorikeet.jar
  - fix-lineages
label: lorikeet_fix-lineages
doc: "Fixes lineages based on input lineage information, phylogenetic tree, and SNP
  matrix.\n\nTool homepage: https://github.com/AbeelLab/lorikeet"
inputs:
  - id: distance
    type:
      - 'null'
      - int
    doc: Maximum distance to consider closest neighbors.
    default: 500
    inputBinding:
      position: 101
      prefix: --distance
  - id: fraction
    type:
      - 'null'
      - float
    doc: Fraction of closest neighbors that need to agree to perform change.
    default: 0.6
    inputBinding:
      position: 101
      prefix: --fraction
  - id: input
    type: string
    doc: Input lineage information. (Output of merge-spoligotypes)
    inputBinding:
      position: 101
      prefix: --input
  - id: snpmatrix
    type: File
    doc: Matrix with pairwise SNP distances (created with pelican)
    inputBinding:
      position: 101
      prefix: --snpmatrix
  - id: tree
    type: File
    doc: Phylogenetic tree file in NWK format.
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: output
    type: File
    doc: Output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet:20--hdfd78af_1
