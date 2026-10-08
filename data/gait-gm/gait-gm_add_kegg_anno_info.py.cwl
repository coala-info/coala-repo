cwlVersion: v1.2
class: CommandLineTool
baseCommand: add_kegg_anno_info.py
label: gait-gm_add_kegg_anno_info.py
doc: "kegg_anno: link gene and metabolite names to KEGG identifiers (downloads from KEGG).

Tool homepage: https://github.com/secimTools/gait-gm"
inputs:
  - id: species
    type: string
    doc: "Specie to download."
    inputBinding:
      position: 101
      prefix: --species
  - id: gene_annot
    type:
      - 'null'
      - File
    doc: "Gene Annotation File."
    inputBinding:
      position: 101
      prefix: --geneAnnot
  - id: gene_uniq_id
    type:
      - 'null'
      - string
    doc: "Name of the column with gene unique Ids."
    inputBinding:
      position: 101
      prefix: --geneUniqId
  - id: gene_name
    type:
      - 'null'
      - string
    doc: "Name of the column with genes names."
    inputBinding:
      position: 101
      prefix: --geneName
  - id: met_annot
    type:
      - 'null'
      - File
    doc: "Metabolite Annotation File."
    inputBinding:
      position: 101
      prefix: --metAnnot
  - id: met_uniq_id
    type:
      - 'null'
      - string
    doc: "Name of the column with metabolite unique Ids."
    inputBinding:
      position: 101
      prefix: --metUniqId
  - id: met_name
    type:
      - 'null'
      - string
    doc: "Name of the column with metabolite names."
    inputBinding:
      position: 101
      prefix: --metName
  - id: gene_out_path
    type:
      - 'null'
      - string
    doc: "Gene Output file name."
    inputBinding:
      position: 101
      prefix: --geneOut
  - id: met_out_path
    type:
      - 'null'
      - string
    doc: "Metabolite Output file name."
    inputBinding:
      position: 101
      prefix: --metOut
outputs:
  - id: gene_out
    type:
      - 'null'
      - File
    doc: "Gene Output file"
    outputBinding:
      glob: $(inputs.gene_out_path)
  - id: met_out
    type:
      - 'null'
      - File
    doc: "Metabolite Output file"
    outputBinding:
      glob: $(inputs.met_out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
