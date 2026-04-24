cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - brlen
label: gotree_brlen
doc: "Set a minimum branch length, or set random branch lengths, or multiply branch
  lengths by a factor.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: external
    type:
      - 'null'
      - boolean
    doc: Applies to external branches
    inputBinding:
      position: 101
      prefix: --external
  - id: format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    inputBinding:
      position: 101
      prefix: --format
  - id: input
    type:
      - 'null'
      - string
    doc: Input tree
    inputBinding:
      position: 101
      prefix: --input
  - id: internal
    type:
      - 'null'
      - boolean
    doc: Applies to internal branches
    inputBinding:
      position: 101
      prefix: --internal
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_brlen.out
