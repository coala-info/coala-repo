cwlVersion: v1.2
class: CommandLineTool
baseCommand: kobas-identify
label: kobas_kobas-identify
doc: "Identify enriched biological terms from foreground and background gene lists.\n\
  \nTool homepage: http://kobas.cbi.pku.edu.cn"
inputs:
  - id: bgfile
    type:
      - 'null'
      - string
    doc: "background file, the output of annotate (3 or 4-letter\n               \
      \         file name is not allowed), or species abbreviation\n             \
      \           (for example: hsa for Homo sapiens, mmu for Mus\n              \
      \          musculus, dme for Drosophila melanogaster, ath for\n            \
      \            Arabidopsis thaliana, sce for Saccharomyces cerevisiae\n      \
      \                  and eco for Escherichia coli K-12 MG1655), default\n    \
      \                    same species as annotate"
    inputBinding:
      position: 101
      prefix: --bgfile
  - id: blast_home
    type:
      - 'null'
      - Directory
    doc: "Optional parameter. To set parent directory of blastx\n                \
      \        and blastp. If you set this parameter, it means you\n             \
      \           set \"blastx\" and \"blastp\" in this following directory.\n   \
      \                     Default value is read from ~/.kobasrc where you set\n\
      \                        before running kobas"
    inputBinding:
      position: 101
      prefix: --blasthome
  - id: blastdb
    type:
      - 'null'
      - Directory
    doc: "Optional parameter. To set path to sep_pep/, default\n                 \
      \       value is read from ~/.kobasrc where you set before\n               \
      \         running kobas"
    inputBinding:
      position: 101
      prefix: --blastdb
  - id: blastp
    type:
      - 'null'
      - File
    doc: "Optional parameter. To set path to blastp program,\n                   \
      \     default value is read from ~/.kobasrc where you set\n                \
      \        before running kobas"
    inputBinding:
      position: 101
      prefix: --blastp
  - id: blastx
    type:
      - 'null'
      - File
    doc: "Optional parameter. To set path to  blasx program,\n                   \
      \     default value is read from ~/.kobasrc where you set\n                \
      \        before running kobas"
    inputBinding:
      position: 101
      prefix: --blastx
  - id: cutoff
    type:
      - 'null'
      - int
    doc: "terms with less than cutoff number of genes are not\n                  \
      \      used for statistical tests, default 5"
    default: 5
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: databases
    type:
      - 'null'
      - string
    doc: "databases for selection, 1-letter abbreviation\n                       \
      \ separated by \"/\": K for KEGG PATHWAY, R for Reactome,\n                \
      \        B for BioCyc, p for PANTHER, o for OMIM, k for KEGG\n             \
      \           DISEASE, N for NHGRI GWAS Catalog, G for Gene\n                \
      \        Ontology,  S for Gene Ontology Slim(GOslim), default\n            \
      \            K/R/B/p/o/k/N/G/S"
    default: K/R/B/p/o/k/N/G/S
    inputBinding:
      position: 101
      prefix: --db
  - id: fdr
    type:
      - 'null'
      - string
    doc: "choose false discovery rate (FDR) correction method:\n                 \
      \       BH for Benjamini and Hochberg, BY for Benjamini and\n              \
      \          Yekutieli, QVALUE, and None, default BH"
    default: BH
    inputBinding:
      position: 101
      prefix: --fdr
  - id: fgfile
    type: File
    doc: foreground file, the output of annotate
    inputBinding:
      position: 101
      prefix: --fgfile
  - id: kobas_home
    type:
      - 'null'
      - Directory
    doc: "Optional parameter. To set path to kobas_home, which\n                 \
      \       is parent directory of sqlite3/ and seq_pep/ ,\n                   \
      \     default\n                        value is read from ~/.kobasrcwhere you
      set before\n                        running kobas. If you set this parameter,
      it means you\n                        set \"kobasdb\" and \"blastdb\" in this
      following\n                        directory. e.g. \"-k /home/user/kobas/\"\
      , means that you\n                        set kobasdb = /home/user/kobas/sqlite3/
      and blastdb = \n                        /home/user/kobas/seq_pep/"
    inputBinding:
      position: 101
      prefix: --kobashome
  - id: kobasdb
    type:
      - 'null'
      - Directory
    doc: "Optional parameter. To set path to sqlite3/, default\n                 \
      \       value is read from ~/.kobasrc where you set before\n               \
      \         running kobas, e.g. \"-q /kobas_home/sqlite3/\""
    inputBinding:
      position: 101
      prefix: --kobasdb
  - id: method
    type:
      - 'null'
      - string
    doc: "choose statistical test method: b for binomial test, c\n               \
      \         for chi-square test, h for hypergeometric test /\n               \
      \         Fisher's exact test, and x for frequency list, default\n         \
      \               hypergeometric test / Fisher's exact test"
    default: hypergeometric test / Fisher's exact test
    inputBinding:
      position: 101
      prefix: --method
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output file for identification result, default stdout
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kobas:3.0.3--py27_1
