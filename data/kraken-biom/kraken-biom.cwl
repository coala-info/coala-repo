cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken-biom
label: kraken-biom
doc: "Create a BIOM table from Kraken reports.\n\nTool homepage: https://github.com/smdabdoub/kraken-biom"
inputs:
  - id: kraken_reports
    type:
      type: array
      items: File
    doc: Kraken report files to process
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (hdf5, json, or tsv)
    default: hdf5
    inputBinding:
      position: 102
      prefix: --fmt
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Gzip compress the output file
    inputBinding:
      position: 102
      prefix: --gzip
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimum count to include a taxon
    default: 0
    inputBinding:
      position: 102
      prefix: --min-count
  - id: min_relative_abundance
    type:
      - 'null'
      - float
    doc: Minimum relative abundance to include a taxon
    default: 0
    inputBinding:
      position: 102
      prefix: --min-relative-abundance
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_fp
    type:
      - 'null'
      - File
    doc: Output BIOM file path
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kraken-biom:1.2.0--pyh5e36f6f_0
