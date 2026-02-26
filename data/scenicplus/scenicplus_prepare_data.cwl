cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - prepare_data
label: scenicplus_prepare_data
doc: "Prepare gene expression, chromatin accessibility and motif enrichment data.\n\
  \nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (prepare_GEX_ACC, prepare_menr, 
      download_genome_annotations, search_spance)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
stdout: scenicplus_prepare_data.out
