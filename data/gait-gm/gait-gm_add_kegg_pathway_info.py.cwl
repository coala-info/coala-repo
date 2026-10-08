cwlVersion: v1.2
class: CommandLineTool
baseCommand: add_kegg_pathway_info.py
label: gait-gm_add_kegg_pathway_info.py
doc: "Kegg Downloader: add KEGG pathway information to gene and metabolite KEGG annotation files (downloads from KEGG).

Tool homepage: https://github.com/secimTools/gait-gm"
inputs:
  - id: species
    type: string
    doc: "Species to download."
    inputBinding:
      position: 101
      prefix: --species
  - id: gene_kegg_annot
    type:
      - 'null'
      - File
    doc: "Gene KEGG Annotation File."
    inputBinding:
      position: 101
      prefix: --geneKeggAnnot
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
  - id: gene_kegg_id
    type:
      - 'null'
      - string
    doc: "Name of the column with gene KEGG Identifiers."
    inputBinding:
      position: 101
      prefix: --geneKeggId
  - id: met_kegg_annot
    type:
      - 'null'
      - File
    doc: "Metabolite KEGG Annotation File."
    inputBinding:
      position: 101
      prefix: --metKeggAnnot
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
  - id: met_kegg_id
    type:
      - 'null'
      - string
    doc: "Name of the column with Metabolite KEGG Identifiers."
    inputBinding:
      position: 101
      prefix: --metKeggId
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
  - id: kgen2pathways_path
    type:
      - 'null'
      - string
    doc: "Gene2Pathway file name."
    inputBinding:
      position: 101
      prefix: --kgen2pathways
  - id: kmet2pathways_path
    type:
      - 'null'
      - string
    doc: "Metabolite2Pathway file name."
    inputBinding:
      position: 101
      prefix: --kmet2pathways
  - id: pathways_path
    type: string
    doc: "PathwaysNames file name."
    inputBinding:
      position: 101
      prefix: --pathways
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
  - id: kgen2pathways
    type:
      - 'null'
      - File
    doc: "Gene2Pathway file"
    outputBinding:
      glob: $(inputs.kgen2pathways_path)
  - id: kmet2pathways
    type:
      - 'null'
      - File
    doc: "Metabolite2Pathway file"
    outputBinding:
      glob: $(inputs.kmet2pathways_path)
  - id: pathways
    type: File
    doc: "PathwaysNames file"
    outputBinding:
      glob: $(inputs.pathways_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
