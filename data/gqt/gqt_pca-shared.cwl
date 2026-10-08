cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gqt
  - pca-shared
label: gqt_pca-shared
doc: "Compute the similarity matrix for PCA based on the number of shared non-reference loci.\n\nTool homepage: https://github.com/ryanlayer/gqt"
inputs:
  - id: gqt_file
    type: File
    secondaryFiles:
      - ^.vid
      - ^.off
      - ^.bim
    doc: gqt file (needs its .vid, .off and .bim files beside it)
    inputBinding:
      position: 101
      prefix: -i
  - id: ped_database_file
    type: File
    doc: ped database file
    inputBinding:
      position: 101
      prefix: -d
  - id: population_queries
    type:
      type: array
      items: string
      inputBinding:
        position: 101
        prefix: -p
    doc: Each population query defines one subpopulation, for example
      "Population = 'GBR'". Population queries are based on the PED file
      associated with the genotypes; any column in that PED file can be part of
      the query. Give one query per subpopulation.
  - id: tmp_directory
    type:
      - 'null'
      - string
    doc: tmp direcory name for remote files
    inputBinding:
      position: 101
      prefix: -t
  - id: label_db_field_name
    type: string
    doc: label db field name (requried for pca-shared)
    inputBinding:
      position: 101
      prefix: -f
  - id: label_output_file
    type: string
    doc: label output file (requried for pca-shared)
    inputBinding:
      position: 101
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: label_file
    type: File
    doc: Label output file
    outputBinding:
      glob: $(inputs.label_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gqt:1.1.3--h0263287_3
stdout: gqt_pca-shared.out
