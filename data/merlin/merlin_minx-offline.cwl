cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - minx-offline
label: merlin_minx-offline
doc: "MERLIN offline association analysis for the X chromosome (minx): association tests using genotypes inferred earlier with minx --infer.\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
  - id: data_file
    type: File
    doc: "Data file, in linkage or QTDT format (-d)"
    inputBinding:
      position: 1
      prefix: '-d'
  - id: pedigree_file
    type: File
    doc: "Pedigree file, with genotype, phenotype and family structure information (-p)"
    inputBinding:
      position: 1
      prefix: '-p'
  - id: map_file
    type: File
    doc: "Map file with chromosome and centimorgan position for each marker (-m)"
    inputBinding:
      position: 1
      prefix: '-m'
  - id: frequency_file
    type:
      - 'null'
      - File
    doc: "Allele frequency file (-f)"
    inputBinding:
      position: 1
      prefix: '-f'
  - id: datinfer
    type:
      - 'null'
      - File
    doc: "Data file of the inferred genotypes (default merlin-infer.dat)"
    inputBinding:
      position: 1
      prefix: '--datinfer'
  - id: pedinfer
    type:
      - 'null'
      - File
    doc: "Pedigree file of the inferred genotypes (default merlin-infer.ped)"
    inputBinding:
      position: 1
      prefix: '--pedinfer'
  - id: inverse_normal
    type:
      - 'null'
      - boolean
    doc: "Apply an inverse normal transformation to the trait"
    inputBinding:
      position: 1
      prefix: '--inverseNormal'
  - id: use_covariates
    type:
      - 'null'
      - boolean
    doc: "Model covariate effects (C columns in the data file)"
    inputBinding:
      position: 1
      prefix: '--useCovariates'
  - id: filter
    type:
      - 'null'
      - float
    doc: "Only output p-values below this threshold"
    inputBinding:
      position: 1
      prefix: '--filter'
  - id: custom
    type:
      - 'null'
      - File
    doc: "Custom covariate table (TRAIT and COVARIATE lines for each trait)"
    inputBinding:
      position: 1
      prefix: '--custom'
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output file names (default merlin)"
    inputBinding:
      position: 1
      prefix: '--prefix'
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: "Write plots to <prefix>.pdf"
    inputBinding:
      position: 1
      prefix: '--pdf'
  - id: tabulate
    type:
      - 'null'
      - boolean
    doc: "Write tab-delimited tables of key results"
    inputBinding:
      position: 1
      prefix: '--tabulate'
outputs:
  - id: stdout
    type: stdout
    doc: "Program report (standard output)"
  - id: result_files
    type:
      type: array
      items: File
    doc: "Result files written with the output prefix (tables, plots)"
    outputBinding:
      glob:
        - "$(inputs.prefix ? inputs.prefix : 'merlin').*"
        - "$(inputs.prefix ? inputs.prefix : 'merlin')-*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_minx-offline.out
