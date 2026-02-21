cwlVersion: v1.2
class: CommandLineTool
baseCommand: array-as-vcf
label: array-as-vcf
doc: "Convert an array file to VCF format\n\nTool homepage: https://github.com/LUMC/array-as-vcf"
inputs:
  - id: build
    type:
      - 'null'
      - string
    doc: Genome build (GRCh37, GRCh38)
    default: GRCh37
    inputBinding:
      position: 101
      prefix: --build
  - id: chr_prefix
    type:
      - 'null'
      - string
    doc: Prefix to chromosome names
    inputBinding:
      position: 101
      prefix: --chr-prefix
  - id: encoding
    type:
      - 'null'
      - string
    doc: Encoding of the array file
    default: UTF-8
    inputBinding:
      position: 101
      prefix: --encoding
  - id: exclude_assays
    type:
      - 'null'
      - type: array
        items: string
    doc: Assay IDs for OpenArray to ignore
    inputBinding:
      position: 101
      prefix: --exclude-assays
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the verbosity of the logger (DEBUG, INFO, WARNING, ERROR)
    default: INFO
    inputBinding:
      position: 101
      prefix: --log-level
  - id: lookup_table
    type:
      - 'null'
      - File
    doc: Path to existing lookup table for rsIDs
    inputBinding:
      position: 101
      prefix: --lookup-table
  - id: no_ensembl_lookup
    type:
      - 'null'
      - boolean
    doc: Lookup missing rsIDs on Ensembl
    inputBinding:
      position: 101
      prefix: --no-ensembl-lookup
  - id: path
    type: File
    doc: Path to array file
    inputBinding:
      position: 101
      prefix: --path
  - id: sample_name
    type: string
    doc: Name of sample in VCF file
    inputBinding:
      position: 101
      prefix: --sample-name
outputs:
  - id: dump
    type:
      - 'null'
      - File
    doc: Path to write generated lookup table
    outputBinding:
      glob: $(inputs.dump)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/array-as-vcf:1.1.0--pyhdfd78af_0
