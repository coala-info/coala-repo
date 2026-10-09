cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kipoi
  - veff
  - score_variants
label: kipoi_veff_score_variants
doc: "Predict effect of SNVs using ISM.\n\nTool homepage: https://github.com/kipoi/kipoi-veff"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: model
    type:
      - string
      - Directory
    doc: Model name; with source dir give the local model directory.
    inputBinding:
      position: 1
  - id: source
    type:
      - 'null'
      - string
    doc: "Model source to use: kipoi, github-permalink or dir."
    inputBinding:
      position: 0
      prefix: --source
  - id: dataloader
    type:
      - 'null'
      - string
    doc: "Dataloader name. If not specified, the model's defaultDataLoader will be used."
    inputBinding:
      position: 0
      prefix: --dataloader
  - id: dataloader_source
    type:
      - 'null'
      - string
    doc: "Dataloader source."
    inputBinding:
      position: 0
      prefix: --dataloader_source
  - id: dataloader_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "DataLoader arguments either as a json string or as a file path to a json file."
    inputBinding:
      position: 0
      prefix: --dataloader_args
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Batch size to use in prediction."
    inputBinding:
      position: 0
      prefix: --batch_size
  - id: num_workers
    type:
      - 'null'
      - int
    doc: "Number of parallel workers for loading the dataset."
    inputBinding:
      position: 0
      prefix: --num_workers
  - id: scores
    type:
      - 'null'
      - type: array
        items: string
    doc: "Scoring method(s) to be used; only methods selected in the model yaml file are available, except diff which is always available."
    inputBinding:
      position: 0
      prefix: --scores
  - id: score_kwargs
    type:
      - 'null'
      - type: array
        items: string
    doc: "JSON definition of the kwargs for the scoring functions selected in scores, as a JSON string or a .json file path, in the same order as scores."
    inputBinding:
      position: 0
      prefix: --score_kwargs
  - id: seq_length
    type:
      - 'null'
      - int
    doc: "Model input sequence length, needed if the model has no pre-defined input sequence length."
    inputBinding:
      position: 0
      prefix: --seq_length
  - id: singularity
    type:
      - 'null'
      - boolean
    doc: "Run kipoi predict in the appropriate singularity container."
    inputBinding:
      position: 0
      prefix: --singularity
  - id: input_vcf
    type: File
    doc: "Input VCF."
    inputBinding:
      position: 0
      prefix: --input_vcf
  - id: restriction_bed
    type:
      - 'null'
      - File
    doc: "Regions for prediction can only be subsets of this bed file."
    inputBinding:
      position: 0
      prefix: --restriction_bed
  - id: std_var_id
    type:
      - 'null'
      - boolean
    doc: "Replace variant IDs in the annotated VCF with a standardised, unique ID."
    inputBinding:
      position: 0
      prefix: --std_var_id
  - id: model_outputs
    type:
      - 'null'
      - type: array
        items: string
    doc: "Only return predictions for the selected model outputs (names from model.yaml schema targets column_labels)."
    inputBinding:
      position: 0
      prefix: --model_outputs
  - id: model_outputs_i
    type:
      - 'null'
      - type: array
        items: int
    doc: "Only return predictions for the selected model outputs, as integer indices."
    inputBinding:
      position: 0
      prefix: --model_outputs_i
  - id: output_vcf_path
    type:
      - 'null'
      - string
    doc: "Output annotated VCF file path."
    inputBinding:
      position: 0
      prefix: --output_vcf
  - id: extra_output_path
    type:
      - 'null'
      - string
    doc: "Additional output file in another format; the format is inferred from the ending (.h5, .hdf5, .pq, .parquet, .zarr, .pqt, .tsv)."
    inputBinding:
      position: 0
      prefix: --extra_output
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Annotated VCF file
    outputBinding:
      glob: $(inputs.output_vcf_path)
  - id: extra_output
    type:
      - 'null'
      - File
    doc: Additional output file in a non-vcf format
    outputBinding:
      glob: $(inputs.extra_output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi_veff:0.3.1--pyh145b6a8_1
