cwlVersion: v1.2
class: CommandLineTool
baseCommand: viguno query
label: viguno_query
doc: "Prepare values for `query`\n\nTool homepage: https://github.com/bihealth/viguno"
inputs:
  - id: path_genes_json
    type: File
    doc: Path to JSON file with the genes to rank
    inputBinding:
      position: 101
      prefix: --path-genes-json
  - id: path_hpo_dir
    type: Directory
    doc: Path to the directory with the HPO files
    inputBinding:
      position: 101
      prefix: --path-hpo-dir
  - id: path_terms_json
    type: File
    doc: Path to JSON file with HPO IDs of patient
    inputBinding:
      position: 101
      prefix: --path-terms-json
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Decrease logging verbosity
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Increase logging verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viguno:0.4.0--h13c227e_0
stdout: viguno_query.out
