cwlVersion: v1.2
class: CommandLineTool
baseCommand: sPLS.py
label: gait-gm_sPLS.py
doc: "sPLS\n\nTool homepage: https://github.com/secimTools/gait-gm"
inputs:
  - id: color
    type:
      - 'null'
      - string
    doc: Name of a valid color scheme on the selected palette
    inputBinding:
      position: 101
      prefix: --color
  - id: correlation
    type:
      - 'null'
      - string
    doc: Compute correlation coefficients using either 'pearson' (standard 
      correlation coefficient), 'kendall' (Kendall Tau correlation coefficient),
      or 'spearman' (Spearman rank correlation).
    inputBinding:
      position: 101
      prefix: --correlation
  - id: cutoff
    type:
      - 'null'
      - float
    doc: 'Variability cut-off value Default: 0.2 (Only required in pana option).'
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: design
    type:
      - 'null'
      - File
    doc: Design file (Only required in mmc or both option).
    inputBinding:
      position: 101
      prefix: --design
  - id: fac_sel
    type:
      - 'null'
      - string
    doc: "criterion to select components. One of 'accum', 'single', 'abs.val' or 'rel.abs'
      Default: 'single'. (Only required in pana option)."
    inputBinding:
      position: 101
      prefix: --facSel
  - id: gene_anno
    type:
      - 'null'
      - File
    doc: Gene Expression Annotation File (Only if user want gene names in 
      output).
    inputBinding:
      position: 101
      prefix: --geneAnno
  - id: gene_dataset
    type: string
    doc: Gene Expression dataset.
    inputBinding:
      position: 101
      prefix: --geneDataset
  - id: gene_id
    type: string
    doc: Gene Unique ID column name.
    inputBinding:
      position: 101
      prefix: --geneId
  - id: gene_kegg_anno
    type:
      - 'null'
      - File
    doc: Gene Expression Add KEGG Annotation Info File (Only required in pana 
      option).
    inputBinding:
      position: 101
      prefix: --geneKeggAnno
  - id: gene_kegg_name
    type:
      - 'null'
      - string
    doc: Name of the column in geneKeggAnno that has Gene Symbols (Only required
      in pana option).
    inputBinding:
      position: 101
      prefix: --geneKeggName
  - id: gene_kegg_path
    type:
      - 'null'
      - File
    doc: Gene Expression Add KEGG Pathway Info File (Only required in path 
      option).
    inputBinding:
      position: 101
      prefix: --geneKeggPath
  - id: gene_list
    type:
      - 'null'
      - string
    doc: Relevant genes to make a sublist (Only required in geneList option).
    inputBinding:
      position: 101
      prefix: --geneList
  - id: gene_name
    type:
      - 'null'
      - string
    doc: Gene Names column name in geneAnno File (Only if user want gene names 
      in output).
    inputBinding:
      position: 101
      prefix: --geneName
  - id: gene_option
    type: string
    doc: 'One of: all, geneList, path, pana.'
    inputBinding:
      position: 101
      prefix: --geneOption
  - id: keep_x
    type: int
    doc: Number of genes to keep in each component.
    inputBinding:
      position: 101
      prefix: --keepX
  - id: met_anno
    type:
      - 'null'
      - File
    doc: Metabolomics Annotation File (Only if user want metabolite names in 
      output).
    inputBinding:
      position: 101
      prefix: --metAnno
  - id: met_dataset
    type: string
    doc: Metabolomic Datset.
    inputBinding:
      position: 101
      prefix: --metDataset
  - id: met_id
    type: string
    doc: Metabolite Unique ID column name.
    inputBinding:
      position: 101
      prefix: --metId
  - id: met_kegg_anno
    type:
      - 'null'
      - File
    doc: Metabolomic Add KEGG Annotation Info File. (Only required if metOption 
      != mmc).
    inputBinding:
      position: 101
      prefix: --metKeggAnno
  - id: met_kegg_path
    type:
      - 'null'
      - File
    doc: Metabolomic Add KEGG Pathway Info File (Only if geneOption = path).
    inputBinding:
      position: 101
      prefix: --metKeggPath
  - id: met_name
    type:
      - 'null'
      - string
    doc: Metabolite Names column name (Only if user want metabolite names in 
      output, or in metOption=generic or both).
    inputBinding:
      position: 101
      prefix: --metName
  - id: met_option
    type: string
    doc: One of generic, mmc or both.
    inputBinding:
      position: 101
      prefix: --metOption
  - id: palette
    type:
      - 'null'
      - string
    doc: Name of the palette to use.
    inputBinding:
      position: 101
      prefix: --palette
  - id: path2genes
    type:
      - 'null'
      - File
    doc: Pathway2Genes File, from Add KEGG Pathway Info Tool (Only required in 
      pana option).
    inputBinding:
      position: 101
      prefix: --path2genes
  - id: path2names
    type:
      - 'null'
      - File
    doc: PathId2PathNames File, from Add KEGG Pathway Info Tool (Only required 
      in pana option and if desired).
    inputBinding:
      position: 101
      prefix: --path2names
  - id: sigma_high
    type:
      - 'null'
      - float
    doc: 'High value of sigma (Default: 0.50).'
    inputBinding:
      position: 101
      prefix: --sigmaHigh
  - id: sigma_low
    type:
      - 'null'
      - float
    doc: 'Low value of sigma (Default: 0.05).'
    inputBinding:
      position: 101
      prefix: --sigmaLow
  - id: sigma_num
    type:
      - 'null'
      - int
    doc: 'Number of values of sigma to search (Default: 451).'
    inputBinding:
      position: 101
      prefix: --sigmaNum
  - id: threshold
    type: string
    doc: Threshold to cut the sPLS output file.
    inputBinding:
      position: 101
      prefix: --thres
outputs:
  - id: figure1
    type: File
    doc: sPLS heatmaps
    outputBinding:
      glob: $(inputs.figure1)
  - id: spls_out
    type: File
    doc: Output Table.
    outputBinding:
      glob: $(inputs.spls_out)
  - id: figure2
    type:
      - 'null'
      - File
    doc: MMC Heatmaps (Only if MMC Option)
    outputBinding:
      glob: $(inputs.figure2)
  - id: mmc_out
    type:
      - 'null'
      - File
    doc: MMC Output TSV name (Only if MMC Option)
    outputBinding:
      glob: $(inputs.mmc_out)
  - id: pana_out
    type:
      - 'null'
      - File
    doc: PANA Output TSV name (Only if PANA Option)
    outputBinding:
      glob: $(inputs.pana_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
