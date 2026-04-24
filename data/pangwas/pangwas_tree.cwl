cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangwas tree
label: pangwas_tree
doc: "Estimate a maximum-likelihood tree with IQ-TREE.\n\nTakes as input a multiple
  sequence alignment in FASTA format. If a SNP\nalignment is provided, an optional
  text file of constant sites can be \nincluded for correction. Outputs a maximum-likelihood
  tree, as well as \nadditional rooted trees if an outgroup is specified in the iqtree
  args.\n\nAny additional arguments will be passed to `iqtree`. If no additional\n\
  arguments are used, the following default args will apply:\n-safe -m MFP\n\nTool
  homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: alignment
    type: File
    doc: Multiple sequence alignment.
    inputBinding:
      position: 101
      prefix: --alignment
  - id: constant_sites
    type:
      - 'null'
      - File
    doc: Text file containing constant sites correction for SNP alignment.
    inputBinding:
      position: 101
      prefix: --constant-sites
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: CPU threads for IQTREE.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
stdout: pangwas_tree.out
