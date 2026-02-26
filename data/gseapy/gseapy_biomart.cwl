cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gseapy
  - biomart
label: gseapy_biomart
doc: "Query Ensembl biomart database.\n\nTool homepage: https://github.com/zqfang/gseapy"
inputs:
  - id: attributes
    type: string
    doc: Which attribute(s) to retrieve. Separate each attr by comma.
    inputBinding:
      position: 101
      prefix: --attributes
  - id: dataset
    type:
      - 'null'
      - string
    doc: 'Which dataset to use. Default: hsapiens_gene_ensembl'
    default: hsapiens_gene_ensembl
    inputBinding:
      position: 101
      prefix: --dataset
  - id: filter_name
    type: string
    doc: Which filter to use. Input filter name, and value. If multi-value 
      required, separate each value by comma. If value is a txt file, then one 
      ID per row, exclude header.
    inputBinding:
      position: 101
      prefix: --filter
  - id: filter_value
    type: string
    doc: Which filter to use. Input filter name, and value. If multi-value 
      required, separate each value by comma. If value is a txt file, then one 
      ID per row, exclude header.
    inputBinding:
      position: 101
      prefix: --filter
  - id: host
    type:
      - 'null'
      - string
    doc: Which host to use. Select from {'www.ensembl.org', 'asia.ensembl.org', 
      'useast.ensembl.org'}.
    inputBinding:
      position: 101
      prefix: --host
  - id: mart
    type:
      - 'null'
      - string
    doc: 'Which mart to use. Default: ENSEMBL_MART_ENSEMBL.'
    default: ENSEMBL_MART_ENSEMBL
    inputBinding:
      position: 101
      prefix: --mart
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity, print out progress of your job
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1
