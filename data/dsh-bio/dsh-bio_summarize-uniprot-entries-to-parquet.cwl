cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-summarize-uniprot-entries-to-parquet
label: dsh-bio_summarize-uniprot-entries-to-parquet
doc: "Summarize UniProt entries to Parquet\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_uniprot_xml_path
    type:
      - 'null'
      - File
    doc: input UniProt XML path
    inputBinding:
      position: 101
      prefix: --input-uniprot-xml-path
  - id: row_group_size
    type:
      - 'null'
      - int
    doc: row group size
    inputBinding:
      position: 101
      prefix: --row-group-size
outputs:
  - id: output_summary_parquet_file
    type: File
    doc: output summary Parquet file
    outputBinding:
      glob: $(inputs.output_summary_parquet_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
