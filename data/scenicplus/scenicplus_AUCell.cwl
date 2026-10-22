cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - grn_inference
  - AUCell
label: scenicplus_AUCell
doc: "Calculate eRegulon enrichment scores using AUCell.\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: eregulon_fname
    type: File
    doc: "Path to eRegulons (.tsv) from scenicplus eGRN."
    inputBinding:
      position: 101
      prefix: --eRegulon_fname
  - id: multiome_mudata_fname
    type: File
    doc: "Path to multiome mudata (.h5mu) from scenicplus prepare_GEX_ACC."
    inputBinding:
      position: 101
      prefix: --multiome_mudata_fname
  - id: aucell_out_fname_path
    type: string
    doc: "Path to store enrichment scores (.h5mu)."
    inputBinding:
      position: 102
      prefix: --aucell_out_fname
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: "Number of cores to use. Default is 1."
    inputBinding:
      position: 101
      prefix: --n_cpu
outputs:
  - id: aucell_out_fname
    type:
      - 'null'
      - File
    doc: "Path to store enrichment scores (.h5mu)."
    outputBinding:
      glob: "$(inputs.aucell_out_fname_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
