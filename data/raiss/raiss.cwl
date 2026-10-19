cwlVersion: v1.2
class: CommandLineTool
baseCommand: raiss
label: raiss
doc: 'Imputes the z-scores of missing SNPs for one trait on one chromosome with RAISS
  (Robust and Accurate Imputation from Summary Statistics).


  Tool homepage: http://statistical-genetics.pages.pasteur.fr/raiss/'
inputs:
  - id: chrom
    type:
      - 'null'
      - string
    doc: chromosome to impute to the chr\d+ format
    inputBinding:
      position: 101
      prefix: --chrom
  - id: gwas
    type:
      - 'null'
      - string
    doc: GWAS to impute to the consortia_trait format
    inputBinding:
      position: 101
      prefix: --gwas
  - id: ref_folder
    type:
      - 'null'
      - Directory
    doc: reference panel location (used to determine which snp to impute)
    inputBinding:
      position: 101
      prefix: --ref-folder
  - id: ld_folder
    type:
      - 'null'
      - Directory
    doc: Location LD correlation matrices
    inputBinding:
      position: 101
      prefix: --ld-folder
  - id: zscore_folder
    type:
      - 'null'
      - Directory
    doc: Location of the zscore files of the gwases to impute
    inputBinding:
      position: 101
      prefix: --zscore-folder
  - id: output_folder
    type:
      - 'null'
      - string
    doc: Location of the impute zscore files
    inputBinding:
      position: 101
      prefix: --output-folder
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of the non overlapping window
    inputBinding:
      position: 101
      prefix: --window-size
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Size of the buffer around the imputation window
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: l2_regularization
    type:
      - 'null'
      - float
    doc: Size of the small value added to the diagonal of the covariance matrix before
      inversion
    inputBinding:
      position: 101
      prefix: --l2-regularization
  - id: eigen_threshold
    type:
      - 'null'
      - float
    doc: threshold under which eigen vectors are removed for the computation of the
      pseudo inverse
    inputBinding:
      position: 101
      prefix: --eigen-threshold
  - id: r2_threshold
    type:
      - 'null'
      - float
    doc: R square (imputation quality) threshold bellow which SNPs are filtered from
      the output
    inputBinding:
      position: 101
      prefix: --R2-threshold
  - id: ld_type
    type:
      - 'null'
      - string
    doc: 'Two options are available : ''plink'' or ''scipy''. Ld can be supplied as
      plink --ld-snp-list output files or as a scipy sparse matrix (.npz) and a .csv
      containing SNPs index'
    inputBinding:
      position: 101
      prefix: --ld-type
  - id: ref_panel_prefix
    type:
      - 'null'
      - string
    doc: prefix for the reference panel files
    inputBinding:
      position: 101
      prefix: --ref-panel-prefix
  - id: ref_panel_suffix
    type:
      - 'null'
      - string
    doc: suffix for the reference panel files
    inputBinding:
      position: 101
      prefix: --ref-panel-suffix
  - id: minimum_ld
    type:
      - 'null'
      - int
    doc: this parameter ensure that their is enough typed SNPs around the imputed
      loci to perform a high accuracy imputation
    inputBinding:
      position: 101
      prefix: --minimum-ld
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: imputed_files
    type:
      type: array
      items: File
    doc: Imputed z-score files written to the output folder
    outputBinding:
      glob: $(inputs.output_folder)/*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raiss:4.0.1--pyhdfd78af_0
stdout: raiss.out
