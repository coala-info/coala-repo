cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - prepare_data
  - search_spance
label: scenicplus_search_spance
doc: "Define the search space around each gene for the region-to-gene links.\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: multiome_mudata_fname
    type: File
    doc: "Path to multiome MuData object (from scenicplus prepare_GEX_ACC)."
    inputBinding:
      position: 101
      prefix: --multiome_mudata_fname
  - id: gene_annotation_fname
    type: File
    doc: "Path to gene annotation tsv (from scenicplus download_genome_annotations)."
    inputBinding:
      position: 101
      prefix: --gene_annotation_fname
  - id: chromsizes_fname
    type: File
    doc: "Path to chromosome sizes tsv (from scenicplus download_genome_annotations)."
    inputBinding:
      position: 101
      prefix: --chromsizes_fname
  - id: out_fname_path
    type: string
    doc: "Out file name for gene search space (tsv)."
    inputBinding:
      position: 102
      prefix: --out_fname
  - id: use_gene_boundaries
    type:
      - 'null'
      - boolean
    doc: "Whether to use the whole search space or stop when encountering another gene."
    inputBinding:
      position: 101
      prefix: --use_gene_boundaries
  - id: upstream
    type:
      - 'null'
      - type: array
        items: int
    doc: "Search space upstream. The minimum (first position) means that even if there is a gene right next to it these bp will be taken. The second position indicates the maximum distance. Default is 1000 150000"
    inputBinding:
      position: 101
      prefix: --upstream
  - id: downstream
    type:
      - 'null'
      - type: array
        items: int
    doc: "Search space downstream. The minimum (first position) means that even if there is a gene right next to it these bp will be taken. The second position indicates the maximum distance. Default is 1000 150000"
    inputBinding:
      position: 101
      prefix: --downstream
  - id: extend_tss
    type:
      - 'null'
      - type: array
        items: int
    doc: "Space around the TSS consider as promoter. Default is 10 10"
    inputBinding:
      position: 101
      prefix: --extend_tss
  - id: remove_promoters
    type:
      - 'null'
      - boolean
    doc: "Whether to remove promoters from the search space or not."
    inputBinding:
      position: 101
      prefix: --remove_promoters
outputs:
  - id: out_fname
    type:
      - 'null'
      - File
    doc: "Out file name for gene search space (tsv)."
    outputBinding:
      glob: "$(inputs.out_fname_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
