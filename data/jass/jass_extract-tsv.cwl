cwlVersion: v1.2
class: CommandLineTool
baseCommand: jass extract-tsv
label: jass_extract-tsv
doc: "Extracts data from an HDF5 table to a TSV file.\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/jass/"
inputs:
  - id: hdf5_table_path
    type: File
    doc: path to the worktable file containing the data
    inputBinding:
      position: 101
      prefix: --hdf5-table-path
  - id: table_key
    type:
      - 'null'
      - string
    doc: "Existing key are 'SumStatTab' : The results of the\n                   \
      \     joint analysis by SNPs - 'PhenoList' : the meta data\n               \
      \         of analysed GWAS - 'COV' : The H0 covariance used to\n           \
      \             perform joint analysis - 'GENCOV' (If present in the\n       \
      \                 initTable): The genetic covariance as computed by the\n  \
      \                      LDscore. Uniquely for the worktable: 'Regions' :\n  \
      \                      Results of the joint analysis summarised by LD regions\n\
      \                        (Notably Lead SNPs by regions) - 'summaryTable': a\n\
      \                        double entry table summarizing the number of\n    \
      \                    significant regions by test (univariate vs joint test)"
    inputBinding:
      position: 101
      prefix: --table-key
  - id: tsv_path
    type: File
    doc: path to the tsv table
    inputBinding:
      position: 101
      prefix: --tsv-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
stdout: jass_extract-tsv.out
