cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mehari
  - db
  - subset
label: mehari_db_subset
doc: "Subset transcript database\n\nTool homepage: https://github.com/varfish-org/mehari"
inputs:
  - id: path_in
    type: File
    doc: "Path to database file to read from"
    inputBinding:
      position: 1
      prefix: --path-in
  - id: path_out
    type: string
    doc: "Path to output file to write to"
    inputBinding:
      position: 2
      prefix: --path-out
  - id: vcf
    type:
      - 'null'
      - File
    doc: "Limit transcript database to the transcripts affected by the variants described in the specified VCF file"
    inputBinding:
      position: 3
      prefix: --vcf
  - id: hgnc_id
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --hgnc-id
    doc: "Limit transcript database to the specified HGNC ID. Can be specified multiple times"
    inputBinding:
      position: 4
  - id: transcript_id
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --transcript-id
    doc: "Limit transcript database to the specified transcript ID. Can be specified multiple times"
    inputBinding:
      position: 5
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase logging verbosity"
    inputBinding:
      position: 6
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Decrease logging verbosity"
    inputBinding:
      position: 7
      prefix: --quiet
outputs:
  - id: subset_db
    type:
      - 'null'
      - File
    doc: "Subset transcript database"
    outputBinding:
      glob: $(inputs.path_out)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
stdout: mehari_db_subset.out
