cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxcltr]
label: phyx_pxcltr
doc: |-
  General tree cleaner.
  Removes annotations (node labels), 'knuckles' (2-degree nodes), and
  root edges to generate a 'vanilla' newick representation.
  By default removes all properties. Alternatively choose 1 property.
  This will take a newick- or nexus-formatted tree from a file or STDIN.
  Output is written in newick format.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: tree_file
    type: File
    doc: "input tree file (newick or nexus)"
    inputBinding:
      prefix: -t
  - id: root
    type: ['null', boolean]
    doc: "remove root edge (if present)"
    inputBinding:
      prefix: -r
  - id: labels
    type: ['null', boolean]
    doc: "remove internal node labels"
    inputBinding:
      prefix: -l
  - id: out_file_path
    type: string
    doc: "output file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "cleaned tree (newick)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
