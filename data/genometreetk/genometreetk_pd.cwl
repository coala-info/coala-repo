cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk pd
label: genometreetk_pd
doc: "Calculate phylogenetic diversity of specified taxa.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: tree
    type: string
    doc: newick tree
    inputBinding:
      position: 1
  - id: taxa_list
    type: File
    doc: list of ingroup taxa, one per line, to calculated PD over
    inputBinding:
      position: 2
  - id: per_taxa_pg_file
    type:
      - 'null'
      - File
    doc: file to record phylogenetic gain of each ingroup taxa relative to the 
      outgroup
    inputBinding:
      position: 103
      prefix: --per_taxa_pg_file
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 103
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
stdout: genometreetk_pd.out
