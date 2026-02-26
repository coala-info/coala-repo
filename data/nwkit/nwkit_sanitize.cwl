cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwkit sanitize
label: nwkit_sanitize
doc: "Sanitize a Newick tree file.\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
  - id: format
    type:
      - 'null'
      - int
    doc: ETE tree format. See here 
      http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html
    default: auto
    inputBinding:
      position: 101
      prefix: --format
  - id: infile
    type:
      - 'null'
      - File
    doc: Input newick file. Use "-" for STDIN.
    default: '-'
    inputBinding:
      position: 101
      prefix: --infile
  - id: name_quote
    type:
      - 'null'
      - string
    doc: Quotation of node and leaf names.none = no quote, single = ', double = 
      "
    default: none
    inputBinding:
      position: 101
      prefix: --name_quote
  - id: outformat
    type:
      - 'null'
      - int
    doc: ETE tree format for --outfile. "auto" indicates the same format as 
      --format.
    default: auto
    inputBinding:
      position: 101
      prefix: --outformat
  - id: quoted_node_names
    type:
      - 'null'
      - string
    doc: Whether node names are quoted in the input file.
    default: yes
    inputBinding:
      position: 101
      prefix: --quoted_node_names
  - id: remove_singleton
    type:
      - 'null'
      - string
    doc: Remove singleton nodes represented as double brackets.
    default: yes
    inputBinding:
      position: 101
      prefix: --remove_singleton
  - id: resolve_polytomy
    type:
      - 'null'
      - string
    doc: Resolve multifurcation (polytomy) nodes into dichotomies with 
      zero-length branches.
    default: no
    inputBinding:
      position: 101
      prefix: --resolve_polytomy
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output newick file. Use "-" for STDOUT.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
