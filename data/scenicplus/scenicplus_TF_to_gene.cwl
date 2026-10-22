cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - grn_inference
  - TF_to_gene
label: scenicplus_TF_to_gene
doc: "Infer TF-to-gene adjacencies with gradient boosting or random forest regression.\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: multiome_mudata_fname
    type: File
    doc: "Path to multiome MuData object (from scenicplus prepare_GEX_ACC)."
    inputBinding:
      position: 101
      prefix: --multiome_mudata_fname
  - id: tf_names
    type: File
    doc: "Path TF names (from scenicplus prepare_menr)."
    inputBinding:
      position: 101
      prefix: --tf_names
  - id: temp_dir
    type: string
    doc: "Path temp dir."
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: out_tf_to_gene_adjacencies_path
    type: string
    doc: "Out file name to store TF to gene adjacencies (tsv)"
    inputBinding:
      position: 102
      prefix: --out_tf_to_gene_adjacencies
  - id: method
    type:
      - 'null'
      - string
    doc: "Regression method to use, either GBM (Gradient Boosting Machine) or RF (Random Forrest). Default is GBM"
    inputBinding:
      position: 101
      prefix: --method
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: "Number of cores to use. Default is 1."
    inputBinding:
      position: 101
      prefix: --n_cpu
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed to use. Default is 666."
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: out_tf_to_gene_adjacencies
    type:
      - 'null'
      - File
    doc: "Out file name to store TF to gene adjacencies (tsv)"
    outputBinding:
      glob: "$(inputs.out_tf_to_gene_adjacencies_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
