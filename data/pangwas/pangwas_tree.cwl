cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - tree
label: pangwas_tree
doc: "Estimate a maximum-likelihood tree with IQ-TREE.\n\nTakes as input a multiple sequence alignment in FASTA format. If a SNP\nalignment is provided, an optional text file of constant sites can be \nincluded for correction. Outputs a maximum-likelihood tree, as well as \nadditional rooted trees if an outgroup is specified in the iqtree args.\n\nAny additional arguments will be passed to `iqtree`. If no additional\narguments are used, the following default args will apply:\n-safe -m MFP\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: alignment
    type: File
    doc: "Multiple sequence alignment."
    inputBinding:
      position: 101
      prefix: --alignment
  - id: constant_sites
    type:
      - 'null'
      - File
    doc: "Text file containing constant sites correction for SNP alignment."
    inputBinding:
      position: 101
      prefix: --constant-sites
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: . )"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: "CPU threads for IQTREE. (default: 1)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: extra_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "Additional arguments passed on to `iqtree`."
    inputBinding:
      position: 200
outputs:
  - id: treefile
    type: File
    doc: "Maximum-likelihood tree from IQ-TREE"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'tree.treefile')"
  - id: tree_rooted
    type: File
    doc: "Rooted tree (newick)"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'tree.rooted.nwk')"
  - id: tree_rooted_plain
    type:
      - 'null'
      - File
    doc: "Rooted tree without support values"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'tree.rooted.plain.nwk')"
  - id: tree_rooted_labelled
    type:
      - 'null'
      - File
    doc: "Rooted tree with labelled nodes"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'tree.rooted.labelled_nodes.nwk')"
  - id: branch_support
    type:
      - 'null'
      - File
    doc: "Table of branch support values"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'tree.rooted.branch_support.tsv')"
  - id: iqtree_report
    type:
      - 'null'
      - File
    doc: "IQ-TREE report"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'tree.iqtree')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
