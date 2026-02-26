cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - resolve
label: gotree_resolve
doc: "Resolve multifurcations by adding 0 length branches.\n\n* If any node has more
  than 3 neighbors :\n   Resolve neighbors randomly by adding 0 length \n   branches
  until it has 3 neighbors\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    default: newick
    inputBinding:
      position: 101
      prefix: --format
  - id: input_file
    type:
      - 'null'
      - string
    doc: Input tree(s) file
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: rooted
    type:
      - 'null'
      - boolean
    doc: Considers the tree as rooted (will randomly resolve the root also if 
      needed)
    inputBinding:
      position: 101
      prefix: --rooted
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    default: -1
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Resolved tree(s) output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
