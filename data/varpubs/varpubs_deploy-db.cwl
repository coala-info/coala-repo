cwlVersion: v1.2
class: CommandLineTool
baseCommand: var pubs deploy-db
label: varpubs_deploy-db
doc: "DeployDBArgs ['args']: Command-line arguments for deploying the PubMed variant
  database.\n\nTool homepage: https://github.com/koesterlab/varpubs"
inputs:
  - id: db_path
    type: Directory
    doc: Path to the DuckDB database file to be created or updated.
    inputBinding:
      position: 101
      prefix: --db_path
  - id: species
    type:
      - 'null'
      - string
    doc: Species for variant annotation
    inputBinding:
      position: 101
      prefix: --species
  - id: vcf_paths
    type:
      type: array
      items: File
    doc: List of VCF files containing variant information.
    inputBinding:
      position: 101
      prefix: --vcf_paths
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varpubs:0.5.0--pyhdfd78af_0
stdout: varpubs_deploy-db.out
