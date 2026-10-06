cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biom
  - convert
label: biom-format_convert
doc: "Convert between BIOM table formats.\n\nTool homepage: http://www.biom-format.org"
inputs:
  - id: input_fp
    type: File
    doc: The input BIOM table
    inputBinding:
      position: 101
      prefix: --input-fp
  - id: output_fp
    type: string
    doc: The output BIOM table
    inputBinding:
      position: 101
      prefix: --output-fp
  - id: sample_metadata_fp
    type:
      - 'null'
      - File
    doc: The sample metadata mapping file (will add sample metadata to the input BIOM table,
      if provided).
    inputBinding:
      position: 101
      prefix: --sample-metadata-fp
  - id: observation_metadata_fp
    type:
      - 'null'
      - File
    doc: The observation metadata mapping file (will add observation metadata to the input
      BIOM table, if provided).
    inputBinding:
      position: 101
      prefix: --observation-metadata-fp
  - id: to_json
    type:
      - 'null'
      - boolean
    doc: Output as JSON-formatted table.
    inputBinding:
      position: 101
      prefix: --to-json
  - id: to_hdf5
    type:
      - 'null'
      - boolean
    doc: Output as HDF5-formatted table.
    inputBinding:
      position: 101
      prefix: --to-hdf5
  - id: to_tsv
    type:
      - 'null'
      - boolean
    doc: Output as TSV-formatted (classic) table.
    inputBinding:
      position: 101
      prefix: --to-tsv
  - id: collapsed_samples
    type:
      - 'null'
      - boolean
    doc: If --to_hdf5 is passed and the original table is a BIOM table with collapsed samples,
      update the sample metadata to the supported HDF5 collapsed format.
    inputBinding:
      position: 101
      prefix: --collapsed-samples
  - id: collapsed_observations
    type:
      - 'null'
      - boolean
    doc: If --to_hdf5 is passed and the original table is a BIOM table with collapsed observations,
      update the observation metadata to the supported HDF5 collapsed format.
    inputBinding:
      position: 101
      prefix: --collapsed-observations
  - id: header_key
    type:
      - 'null'
      - string
    doc: The observation metadata to include from the input BIOM table file when creating
      a tsv table file.
    inputBinding:
      position: 101
      prefix: --header-key
  - id: output_metadata_id
    type:
      - 'null'
      - string
    doc: The name to be given to the observation metadata column when creating a tsv table
      file if the column should be renamed.
    inputBinding:
      position: 101
      prefix: --output-metadata-id
  - id: table_type
    type:
      - 'null'
      - string
    doc: The type of the table (OTU table, Pathway table, Function table, Ortholog table,
      Gene table, Metabolite table, Taxon table, Table).
    inputBinding:
      position: 101
      prefix: --table-type
  - id: process_obs_metadata
    type:
      - 'null'
      - string
    doc: Process metadata associated with observations when converting from a classic table
      (sc_separated, naive, taxonomy).
    inputBinding:
      position: 101
      prefix: --process-obs-metadata
  - id: tsv_metadata_formatter
    type:
      - 'null'
      - string
    doc: Method for formatting the observation metadata (sc_separated, naive).
    inputBinding:
      position: 101
      prefix: --tsv-metadata-formatter
outputs:
  - id: output_table
    type: File
    doc: The output BIOM table
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biom-format:2.1.15
