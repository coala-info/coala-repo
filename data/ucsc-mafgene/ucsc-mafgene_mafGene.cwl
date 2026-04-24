cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafGene
label: ucsc-mafgene_mafGene
doc: "output protein alignments using maf and genePred\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: db_name
    type: string
    doc: name of SQL database
    inputBinding:
      position: 1
  - id: maf_table
    type: string
    doc: name of maf file table or bigMaf if ends in .bigMaf or .bb
    inputBinding:
      position: 2
  - id: gene_pred_table
    type: string
    doc: name of the genePred table or file if useFile is on or ends in .gp
    inputBinding:
      position: 3
  - id: species_list
    type: string
    doc: list of species names
    inputBinding:
      position: 4
  - id: output
    type: string
    doc: put output here
    inputBinding:
      position: 5
  - id: chrom
    type:
      - 'null'
      - string
    doc: name of chromosome from which to grab genes
    inputBinding:
      position: 106
      prefix: -chrom
  - id: delay
    type:
      - 'null'
      - int
    doc: delay N seconds between genes (default 0)
    inputBinding:
      position: 106
      prefix: -delay
  - id: exons
    type:
      - 'null'
      - boolean
    doc: output exons
    inputBinding:
      position: 106
      prefix: -exons
  - id: gene_beds
    type:
      - 'null'
      - File
    doc: name of bed file with genes and positions
    inputBinding:
      position: 106
      prefix: -geneBeds
  - id: gene_list
    type:
      - 'null'
      - File
    doc: name of file with list of genes
    inputBinding:
      position: 106
      prefix: -geneList
  - id: gene_name
    type:
      - 'null'
      - string
    doc: name of gene as it appears in genePred
    inputBinding:
      position: 106
      prefix: -geneName
  - id: include_utr
    type:
      - 'null'
      - boolean
    doc: include the UTRs, use only with -noTrans
    inputBinding:
      position: 106
      prefix: -includeUtr
  - id: no_dash
    type:
      - 'null'
      - boolean
    doc: don't output lines with all dashes
    inputBinding:
      position: 106
      prefix: -noDash
  - id: no_trans
    type:
      - 'null'
      - boolean
    doc: don't translate output into amino acids
    inputBinding:
      position: 106
      prefix: -noTrans
  - id: two_bit
    type:
      - 'null'
      - File
    doc: use 2bit file to fill in spaces in the alignment instead of database
    inputBinding:
      position: 106
      prefix: -twoBit
  - id: uniq_aa
    type:
      - 'null'
      - boolean
    doc: put out unique pseudo-AA for every different codon
    inputBinding:
      position: 106
      prefix: -uniqAA
  - id: use_file
    type:
      - 'null'
      - boolean
    doc: genePredTable is a file
    inputBinding:
      position: 106
      prefix: -useFile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafgene:490--ha62e71f_1
stdout: ucsc-mafgene_mafGene.out
