cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgatk
  - cbioportal-to-proteindb
label: pypgatk_cbioportal-to-proteindb
doc: "Configuration for cbioportal to proteindb tool\n\nTool homepage: http://github.com/bigbio/py-pgatk"
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
  - id: clinical_sample_file
    type:
      - 'null'
      - string
    doc: File to get tissue type from for the samples in input_mutation file
    inputBinding:
      position: 101
      prefix: --clinical_sample_file
  - id: config_file
    type:
      - 'null'
      - string
    doc: Configuration for cbioportal to proteindb tool
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
  - id: input_cds
    type:
      - 'null'
      - string
    doc: CDS genes from ENSEMBL database
    inputBinding:
      position: 101
      prefix: --input_cds
  - id: input_mutation
    type:
      - 'null'
      - string
    doc: Cbioportal mutation file
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
