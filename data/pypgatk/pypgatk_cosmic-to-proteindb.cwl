cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgatk cosmic-to-proteindb
label: pypgatk_cosmic-to-proteindb
doc: "Convert COSMIC mutation data to a protein database.\n\nTool homepage: http://github.com/bigbio/py-pgatk"
inputs:
  - id: accepted_values
    type:
      - 'null'
      - string
    doc: Limit mutations to values (tissue type, sample name, etc) considered 
      for generating proteinDBs, by default mutations from all records are 
      considered (e.g. "")
    inputBinding:
      position: 101
      prefix: --accepted_values
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file for the cosmic data pipelines
    inputBinding:
      position: 101
      prefix: --config_file
  - id: filter_column
    type:
      - 'null'
      - string
    doc: Column in the VCF file to be used for filtering or splitting mutations
    inputBinding:
      position: 101
      prefix: --filter_column
  - id: input_genes
    type:
      - 'null'
      - File
    doc: All Cosmic genes
    inputBinding:
      position: 101
      prefix: --input_genes
  - id: input_mutation
    type:
      - 'null'
      - File
    doc: Cosmic Mutation data file
    inputBinding:
      position: 101
      prefix: --input_mutation
  - id: split_by_filter_column
    type:
      - 'null'
      - boolean
    doc: Use this flag to generate a proteinDB per group as specified in the 
      filter_column, default is False
    inputBinding:
      position: 101
      prefix: --split_by_filter_column
outputs:
  - id: output_db
    type:
      - 'null'
      - File
    doc: Protein database including all the mutations
    outputBinding:
      glob: $(inputs.output_db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
