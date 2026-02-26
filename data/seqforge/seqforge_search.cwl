cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqforge
  - search
label: seqforge_search
doc: "Extract metadata from GenBank or JSON files.\n\nTool homepage: https://github.com/ERBringHorvath/SeqForge"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Extract all available metadata
    inputBinding:
      position: 101
      prefix: --all
  - id: fields
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Space-separated list of metadata fields to extract. Allowed fields: accession,
      organism, strain, isolation_source, host, region, lat_lon, collection_date,
      collected_by, tax_id, comment, keywords, sequencing_tech, release_date'
    inputBinding:
      position: 101
      prefix: --fields
  - id: gb
    type:
      - 'null'
      - boolean
    doc: Parse only GenBank files in the input directory
    inputBinding:
      position: 101
      prefix: --gb
  - id: input
    type: File
    doc: Input file (.json or .gb/.gbk/.genbank)
    inputBinding:
      position: 101
      prefix: --input
  - id: json
    type:
      - 'null'
      - boolean
    doc: Parse only JSON files in the input directory
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: output
    type: File
    doc: Output file (e.g., .csv, .tsv, .json)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
