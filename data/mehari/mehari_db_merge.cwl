cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mehari
  - db
  - merge
label: mehari_db_merge
doc: "Merge two or more mehari transcript databases\n\nTool homepage: https://github.com/varfish-org/mehari"
inputs:
  - id: database
    type:
      - type: array
        items: File
        inputBinding:
          prefix: --database
    doc: "The input transcript databases to merge"
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output file to write the merged transcript database to"
    inputBinding:
      position: 2
      prefix: --output
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "ZSTD compression level to use (default: 19)"
    inputBinding:
      position: 3
      prefix: --compression-level
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase logging verbosity"
    inputBinding:
      position: 4
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Decrease logging verbosity"
    inputBinding:
      position: 5
      prefix: --quiet
outputs:
  - id: merged_db
    type:
      - 'null'
      - File
    doc: "Merged transcript database"
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
stdout: mehari_db_merge.out
