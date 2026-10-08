cwlVersion: v1.2
class: CommandLineTool
baseCommand: ensembl2symbol.py
label: gait-gm_ensembl2symbol.py
doc: "kegg_anno: add gene symbols to a gene annotation file from ENSEMBL identifiers (downloads from ENSEMBL).

Tool homepage: https://github.com/secimTools/gait-gm"
inputs:
  - id: species
    type: string
    doc: "Species to download. One of rat, human, mouse, fruitfly, thale cress, yeast, E. coli, or nematode"
    inputBinding:
      position: 101
      prefix: --species
  - id: gene_annot
    type: File
    doc: "Gene Expression Annotation File."
    inputBinding:
      position: 101
      prefix: --geneAnnot
  - id: uniq_id
    type: string
    doc: "Name of the column with gene Unique Ids."
    inputBinding:
      position: 101
      prefix: --uniqId
  - id: ensembl_id
    type: string
    doc: "Name of the column with ENSEMBL IDs."
    inputBinding:
      position: 101
      prefix: --ensemblId
  - id: output_path
    type: string
    doc: "Gene expression Annotation File with Gene Symbols."
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output
    type: File
    doc: "Gene expression Annotation File with Gene Symbols"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
