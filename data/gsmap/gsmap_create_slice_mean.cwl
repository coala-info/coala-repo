cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsMap create_slice_mean
label: gsmap_create_slice_mean
doc: "Calculates the mean expression for each slice across specified samples.\n\n\
  Tool homepage: https://github.com/LeonSong1995/gsMap"
inputs:
  - id: sample_name_list
    type:
      type: array
      items: string
    doc: List of sample names to process. Provide as a space-separated list.
    inputBinding:
      position: 1
  - id: data_layer
    type:
      - 'null'
      - string
    doc: Data layer for gene expression (e.g., "count", "counts", "log1p").
    default: counts
    inputBinding:
      position: 102
      prefix: --data_layer
  - id: h5ad_list
    type:
      - 'null'
      - type: array
        items: File
    doc: List of h5ad file paths corresponding to the sample names. Provide as a
      space-separated list.
    default: None
    inputBinding:
      position: 102
      prefix: --h5ad_list
  - id: h5ad_yaml
    type:
      - 'null'
      - File
    doc: Path to the YAML file containing sample names and associated h5ad file 
      paths
    default: None
    inputBinding:
      position: 102
      prefix: --h5ad_yaml
  - id: homolog_file
    type:
      - 'null'
      - File
    doc: Path to homologous gene conversion file (optional).
    default: None
    inputBinding:
      position: 102
      prefix: --homolog_file
outputs:
  - id: slice_mean_output_file
    type: File
    doc: Path to the output file for the slice mean
    outputBinding:
      glob: $(inputs.slice_mean_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
