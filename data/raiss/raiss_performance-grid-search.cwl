cwlVersion: v1.2
class: CommandLineTool
baseCommand: raiss performance-grid-search
label: raiss_performance-grid-search
doc: "Performs a grid search for RAISS performance tuning.\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/raiss/"
inputs:
  - id: eigen_ratio_grid
    type: string
    doc: main parameter to tune. Adjust the regularization when computing the 
      pseudo inverse of LD matrices
    inputBinding:
      position: 101
      prefix: --eigen-ratio-grid
  - id: harmonized_folder
    type: Directory
    doc: folder containing data before imputation
    inputBinding:
      position: 101
      prefix: --harmonized-folder
  - id: imputed_folder
    type: Directory
    doc: folder to store imputed files
    inputBinding:
      position: 101
      prefix: --imputed-folder
  - id: ld_threshold_grid
    type:
      - 'null'
      - string
    doc: optional parameter to tune. raising the threshold will augment the 
      number neighboring of SNPs required for the imputation to be consider 
      valid (i.e. missing SNPs with only few neighbor won't be imputed). 
      Empirically this parameter seems to impact more the maximum error than the
      mean/median error
    inputBinding:
      position: 101
      prefix: --ld-threshold-grid
  - id: masked_folder
    type: Directory
    doc: folder to store zscore with masked SNPs (raiss performance-grid-search 
      will generate them)
    inputBinding:
      position: 101
      prefix: --masked-folder
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: Number of cpu to use to run imputation in Parallel for each parameter 
      value
    inputBinding:
      position: 101
      prefix: --n-cpu
  - id: n_to_mask
    type:
      - 'null'
      - int
    doc: Number of SNPs to mask. Should only be a relatively small fraction 
      (e.g. ~1/10)of the number of your initial data
    inputBinding:
      position: 101
      prefix: --N-to-mask
  - id: output_path
    type: string
    doc: path+prefix of the report file, the file will be suffixed by the trait 
      name and .txt
    inputBinding:
      position: 101
      prefix: --output-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raiss:4.0.1--pyhdfd78af_0
stdout: raiss_performance-grid-search.out
