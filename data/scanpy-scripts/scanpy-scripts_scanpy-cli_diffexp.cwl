cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - diffexp
label: scanpy-scripts_scanpy-cli_diffexp
doc: "Find markers for each clusters.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
inputs:
  - id: input_obj
    type: File
    doc: input file in format specified by --input-format
    inputBinding:
      position: 1
  - id: output_obj_path
    type: string
    doc: output file in format specified by --output-format
    inputBinding:
      position: 2
  - id: input_format
    type:
      - 'null'
      - string
    doc: "Input object format."
    inputBinding:
      position: 101
      prefix: --input-format
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output object format."
    inputBinding:
      position: 101
      prefix: --output-format
  - id: zarr_chunk_size
    type:
      - 'null'
      - int
    doc: "Chunk size for writing output in zarr format."
    inputBinding:
      position: 101
      prefix: --zarr-chunk-size
  - id: loom_write_obsm_varm
    type:
      - 'null'
      - boolean
    doc: "Write obsm and varm to the Loom file?"
    inputBinding:
      position: 101
      prefix: --loom-write-obsm-varm
  - id: export_mtx_path
    type:
      - 'null'
      - string
    doc: "When specified, using it as prefix for exporting mtx files. If not empty and not ending with \"/\" or \"_\", a \"_\" will be appended."
    inputBinding:
      position: 101
      prefix: --export-mtx
  - id: mtx_compression
    type:
      - 'null'
      - string
    doc: "Compression type for MTX output."
    inputBinding:
      position: 101
      prefix: --mtx-compression
  - id: show_obj
    type:
      - 'null'
      - string
    doc: "Print output object summary info to specified stream."
    inputBinding:
      position: 101
      prefix: --show-obj
  - id: use_raw
    type:
      - 'null'
      - boolean
    doc: "Use expression values in `.raw` if present. (--use-raw)"
    inputBinding:
      position: 101
      prefix: --use-raw
  - id: no_raw
    type:
      - 'null'
      - boolean
    doc: "Use expression values in `.raw` if present. (--no-raw)"
    inputBinding:
      position: 101
      prefix: --no-raw
  - id: key_added
    type:
      - 'null'
      - type: array
        items: string
    doc: "Key under which to add the computed results"
    inputBinding:
      position: 101
      prefix: --key-added
      itemSeparator: ','
  - id: layer
    type:
      - 'null'
      - string
    doc: "Key from adata.layers whose value will be used to perform tests on."
    inputBinding:
      position: 101
      prefix: --layer
  - id: groupby
    type:
      - 'null'
      - string
    doc: "The key of the observations grouping to consider."
    inputBinding:
      position: 101
      prefix: --groupby
  - id: groups
    type:
      - 'null'
      - type: array
        items: string
    doc: "Subset of groups to which comparison shall be restricted."
    inputBinding:
      position: 101
      prefix: --groups
      itemSeparator: ','
  - id: reference
    type:
      - 'null'
      - string
    doc: "If \"rest\", compare each group to the union of the rest of the groups. If a group identifier, compare with respect to this group."
    inputBinding:
      position: 101
      prefix: --reference
  - id: n_genes
    type:
      - 'null'
      - int
    doc: "The number of genes that appear in the retured tables. By default return all available genes depending on the value of --use-raw."
    inputBinding:
      position: 101
      prefix: --n-genes
  - id: method
    type:
      - 'null'
      - string
    doc: "Method of performing differential expression analysis."
    inputBinding:
      position: 101
      prefix: --method
  - id: corr_method
    type:
      - 'null'
      - string
    doc: "P-value correction method. Used only for \"t-test\", \"t-test_overestim_var\" and \"wilcoxon\"."
    inputBinding:
      position: 101
      prefix: --corr-method
  - id: rankby_abs
    type:
      - 'null'
      - boolean
    doc: "Rank genes by the absolute value of the score, not by the score. The returned scores are never the absolute values."
    inputBinding:
      position: 101
      prefix: --rankby-abs
  - id: pts
    type:
      - 'null'
      - boolean
    doc: "Compute the fraction of cells expressing the genes."
    inputBinding:
      position: 101
      prefix: --pts
  - id: tie_correct
    type:
      - 'null'
      - boolean
    doc: "Use tie correction for 'wilcoxon' scores. Used only for 'wilcoxon'."
    inputBinding:
      position: 101
      prefix: --tie-correct
  - id: filter_params
    type:
      - 'null'
      - type: array
        items: string
    doc: "Parameters for filtering DE results, valid parameters are: \"min_in_group_fraction\" (float), \"max_out_group_fraction\" (float), \"min_fold_change\" (float)."
    inputBinding:
      position: 101
      prefix: --filter-params
      itemSeparator: ','
  - id: logreg_param
    type:
      - 'null'
      - type: array
        items: string
    doc: "Parameters passed to `sklearn.linear_model.LogisticRegression`."
    inputBinding:
      position: 101
      prefix: --logreg-param
      itemSeparator: ','
  - id: save_path
    type:
      - 'null'
      - string
    doc: "Tab-separated table to store results of differential expression analysis."
    inputBinding:
      position: 101
      prefix: --save
outputs:
  - id: output_obj
    type:
      - File
      - Directory
    doc: output object (a directory for the zarr format)
    outputBinding:
      glob: $(inputs.output_obj_path)
  - id: export_mtx
    type:
      type: array
      items: File
    doc: "When specified, using it as prefix for exporting mtx files. If not empty and not ending with \"/\" or \"_\", a \"_\" will be appended. (files written with the given prefix)"
    outputBinding:
      glob: $(inputs.export_mtx_path)*
  - id: save
    type:
      - 'null'
      - File
    doc: "Tab-separated table to store results of differential expression analysis."
    outputBinding:
      glob: $(inputs.save_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
