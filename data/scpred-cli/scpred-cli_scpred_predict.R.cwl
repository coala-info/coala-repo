cwlVersion: v1.2
class: CommandLineTool
baseCommand: scpred_predict.R
label: scpred-cli_scpred_predict.R
doc: "Predicts cell types using scPred.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scPred-cli"
inputs:
  - id: input_object
    type:
      - 'null'
      - File
    doc: Path to the input object of scPred or seurat class in .rds format
    inputBinding:
      position: 101
      prefix: --input-object
  - id: max_iter_harmony
    type:
      - 'null'
      - int
    doc: Maximum number of rounds to run Harmony. One round of Harmony involves 
      one clustering and one correction step
    inputBinding:
      position: 101
      prefix: --max-iter-harmony
  - id: normalisation_method
    type:
      - 'null'
      - string
    doc: 'If --normalise-data specified, what normalisation method to use? NB: normalisation
      method must be identical to that used for reference data'
    inputBinding:
      position: 101
      prefix: --normalisation-method
  - id: normalise_data
    type:
      - 'null'
      - boolean
    doc: Should the predicted expression data be normalised?
    inputBinding:
      position: 101
      prefix: --normalise-data
  - id: pred_data
    type:
      - 'null'
      - File
    doc: Path to the input prediction matrix in .rds format
    inputBinding:
      position: 101
      prefix: --pred-data
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random number generator seed
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: recompute_alignment
    type:
      - 'null'
      - boolean
    doc: Recompute alignment? Useful if scPredict() has already been run.
    inputBinding:
      position: 101
      prefix: --recompute-alignment
  - id: reference_scaling
    type:
      - 'null'
      - boolean
    doc: Scale new dataset based on means and stdevs from reference dataset 
      before alignment.
    inputBinding:
      position: 101
      prefix: --reference-scaling
  - id: scale_factor
    type:
      - 'null'
      - float
    doc: 'If --normalise-data specified, what scale factor should be applied? Note:
      for CPM normalisation, select 1e6'
    inputBinding:
      position: 101
      prefix: --scale-factor
  - id: threshold_level
    type:
      - 'null'
      - float
    doc: Classification threshold value
    inputBinding:
      position: 101
      prefix: --threshold-level
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Output path for Seurat object holding predicted values
    outputBinding:
      glob: $(inputs.output_path)
  - id: plot_path
    type:
      - 'null'
      - File
    doc: Output path for prediction probabilities histograms in .png format
    outputBinding:
      glob: $(inputs.plot_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scpred-cli:0.1.0--hdfd78af_2
