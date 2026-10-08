cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pedstats
label: merlin_pedstats
doc: "Pedigree Statistics 0.6.10: summarise pedigree structure, phenotypes, genotypes and Mendelian consistency of pedigree files.\n\nTool homepage: http://csg.sph.umich.edu/abecasis/pedstats"
inputs:
  - id: data_file
    type: File
    doc: "Data file, in linkage or QTDT format (-d)"
    inputBinding:
      position: 1
      prefix: '-d'
  - id: pedigree_file
    type: File
    doc: "Pedigree file (-p)"
    inputBinding:
      position: 1
      prefix: '-p'
  - id: ibd_file
    type:
      - 'null'
      - File
    doc: "IBD file with pairwise IBD coefficients (-i)"
    inputBinding:
      position: 1
      prefix: '-i'
  - id: pdf_file_name
    type:
      - 'null'
      - string
    doc: "Name of the Adobe PDF output file (-a, default pedstats.pdf)"
    inputBinding:
      position: 1
      prefix: '-a'
  - id: missing_value_code
    type:
      - 'null'
      - string
    doc: "Missing value code for quantitative phenotypes and covariates (-x, default -99.999)"
    inputBinding:
      position: 1
      prefix: '-x'
  - id: ignore_mendelian_errors
    type:
      - 'null'
      - boolean
    doc: "Ignore Mendelian inconsistencies when loading the pedigree"
    inputBinding:
      position: 1
      prefix: '--ignoreMendelianErrors'
  - id: chromosome_x
    type:
      - 'null'
      - boolean
    doc: "Treat markers as X-linked"
    inputBinding:
      position: 1
      prefix: '--chromosomeX'
  - id: trim
    type:
      - 'null'
      - boolean
    doc: "Trim uninformative individuals from pedigrees"
    inputBinding:
      position: 1
      prefix: '--trim'
  - id: hardy_weinberg
    type:
      - 'null'
      - boolean
    doc: "Test markers for Hardy-Weinberg equilibrium"
    inputBinding:
      position: 1
      prefix: '--hardyWeinberg'
  - id: show_all
    type:
      - 'null'
      - boolean
    doc: "Show Hardy-Weinberg results for all markers"
    inputBinding:
      position: 1
      prefix: '--showAll'
  - id: cutoff
    type:
      - 'null'
      - float
    doc: "Hardy-Weinberg p-value cutoff (default 0.05)"
    inputBinding:
      position: 1
      prefix: '--cutoff'
  - id: check_founders
    type:
      - 'null'
      - boolean
    doc: "Hardy-Weinberg test on founders"
    inputBinding:
      position: 1
      prefix: '--checkFounders'
  - id: check_all
    type:
      - 'null'
      - boolean
    doc: "Hardy-Weinberg test on all individuals"
    inputBinding:
      position: 1
      prefix: '--checkAll'
  - id: check_unrelated
    type:
      - 'null'
      - boolean
    doc: "Hardy-Weinberg test on an unrelated subset"
    inputBinding:
      position: 1
      prefix: '--checkUnrelated'
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: "Tabulate relative pairs"
    inputBinding:
      position: 1
      prefix: '--pairs'
  - id: rewrite_pedigree
    type:
      - 'null'
      - boolean
    doc: "Write the cleaned pedigree and data files (pedstats.ped and pedstats.dat)"
    inputBinding:
      position: 1
      prefix: '--rewritePedigree'
  - id: marker_tables
    type:
      - 'null'
      - boolean
    doc: "Write marker information tables (pedstats.markerinfo)"
    inputBinding:
      position: 1
      prefix: '--markerTables'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose output"
    inputBinding:
      position: 1
      prefix: '--verbose'
  - id: by_sex
    type:
      - 'null'
      - boolean
    doc: "Report statistics by sex"
    inputBinding:
      position: 1
      prefix: '--bySex'
  - id: by_family
    type:
      - 'null'
      - boolean
    doc: "Report statistics by family"
    inputBinding:
      position: 1
      prefix: '--byFamily'
  - id: age
    type:
      - 'null'
      - string
    doc: "Name of the age covariate used for age checking"
    inputBinding:
      position: 1
      prefix: '--age'
  - id: birth
    type:
      - 'null'
      - string
    doc: "Name of the birth year covariate used for age checking"
    inputBinding:
      position: 1
      prefix: '--birth'
  - id: min_gap
    type:
      - 'null'
      - float
    doc: "Minimum parent-offspring age gap in years (default 13)"
    inputBinding:
      position: 1
      prefix: '--minGap'
  - id: max_gap
    type:
      - 'null'
      - float
    doc: "Maximum parent-offspring age gap in years (default 70)"
    inputBinding:
      position: 1
      prefix: '--maxGap'
  - id: sib_gap
    type:
      - 'null'
      - float
    doc: "Maximum sibling age gap in years (default 30)"
    inputBinding:
      position: 1
      prefix: '--sibGap'
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: "Write a PDF report"
    inputBinding:
      position: 1
      prefix: '--pdf'
  - id: family_pdf
    type:
      - 'null'
      - boolean
    doc: "Add family structure plots to the PDF report"
    inputBinding:
      position: 1
      prefix: '--familyPDF'
  - id: trait_pdf
    type:
      - 'null'
      - boolean
    doc: "Add trait plots to the PDF report"
    inputBinding:
      position: 1
      prefix: '--traitPDF'
  - id: aff_pdf
    type:
      - 'null'
      - boolean
    doc: "Add affection status plots to the PDF report"
    inputBinding:
      position: 1
      prefix: '--affPDF'
  - id: marker_pdf
    type:
      - 'null'
      - boolean
    doc: "Add marker plots to the PDF report"
    inputBinding:
      position: 1
      prefix: '--markerPDF'
  - id: min_genos
    type:
      - 'null'
      - int
    doc: "Remove individuals genotyped on fewer than this many markers"
    inputBinding:
      position: 1
      prefix: '--minGenos'
  - id: min_phenos
    type:
      - 'null'
      - int
    doc: "Remove individuals measured for fewer than this many traits"
    inputBinding:
      position: 1
      prefix: '--minPhenos'
  - id: min_covariates
    type:
      - 'null'
      - int
    doc: "Remove individuals measured for fewer than this many covariates"
    inputBinding:
      position: 1
      prefix: '--minCovariates'
  - id: affected_for
    type:
      - 'null'
      - string
    doc: "Keep only individuals affected for this disease"
    inputBinding:
      position: 1
      prefix: '--affectedFor'
outputs:
  - id: stdout
    type: stdout
    doc: "Program report (standard output)"
  - id: pdf_report
    type:
      - 'null'
      - File
    doc: "PDF report (--pdf and related options)"
    outputBinding:
      glob: "*.pdf"
  - id: rewritten_data
    type:
      - 'null'
      - File
    doc: "Rewritten data file (--rewritePedigree)"
    outputBinding:
      glob: "pedstats.dat"
  - id: rewritten_pedigree
    type:
      - 'null'
      - File
    doc: "Rewritten pedigree file (--rewritePedigree)"
    outputBinding:
      glob: "pedstats.ped"
  - id: marker_info
    type:
      - 'null'
      - File
    doc: "Marker information table (--markerTables)"
    outputBinding:
      glob: "pedstats.markerinfo"
  - id: hwe_selection
    type:
      - 'null'
      - File
    doc: "Hardy-Weinberg selection table"
    outputBinding:
      glob: "pedstats.hweselection"
  - id: other_tables
    type:
      type: array
      items: File
    doc: "Other tables written by the program"
    outputBinding:
      glob:
        - "pedstats.*.tbl"
        - "pedstats.*.txt"
        - "pedstats.pairs"
        - "pedstats.err"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_pedstats.out
