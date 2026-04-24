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
    inputBinding:
      position: 101
      prefix: --format
  - id: infile
    type:
      - 'null'
      - File
    doc: Input newick file. Use "-" for STDIN.
    inputBinding:
      position: 101
      prefix: --infile
  - id: name_quote
    type:
      - 'null'
      - string
    doc: Quotation of node and leaf names.none = no quote, single = ', double = 
      "
    inputBinding:
      position: 101
      prefix: --name_quote
  - id: outformat
    type:
      - 'null'
      - int
    doc: ETE tree format for --outfile. "auto" indicates the same format as 
      --format.
    inputBinding:
      position: 101
      prefix: --outformat
  - id: quoted_node_names
    type:
      - 'null'
      - string
    doc: Whether node names are quoted in the input file.
    inputBinding:
      position: 101
      prefix: --quoted_node_names
  - id: remove_singleton
    type:
      - 'null'
      - string
    doc: Remove singleton nodes represented as double brackets.
    inputBinding:
      position: 101
      prefix: --remove_singleton
  - id: resolve_polytomy
    type:
      - 'null'
      - string
    doc: Resolve multifurcation (polytomy) nodes into dichotomies with 
      zero-length branches.
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
