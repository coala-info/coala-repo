cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mehari
  - db
  - check
label: mehari_db_check
doc: "Check transcript database\n\nTool homepage: https://github.com/varfish-org/mehari"
inputs:
  - id: db
    type: File
    doc: "Path to the transcript database file to check"
    inputBinding:
      position: 1
      prefix: --db
  - id: cdot
    type:
      - type: array
        items: File
        inputBinding:
          prefix: --cdot
    doc: "Paths to the cdot JSON files to check against"
    inputBinding:
      position: 2
  - id: hgnc
    type: File
    doc: "Path to the HGNC JSON file to check against"
    inputBinding:
      position: 3
      prefix: --hgnc
  - id: disease_genes
    type: File
    doc: "Path to the disease gene TSV file to check against"
    inputBinding:
      position: 4
      prefix: --disease-genes
  - id: known_issues
    type: File
    doc: "Path to the known issues TSV"
    inputBinding:
      position: 5
      prefix: --known-issues
  - id: clinvar_hgnc_counts
    type: File
    doc: "Path to hgncId to count mapping"
    inputBinding:
      position: 6
      prefix: --clinvar-hgnc-counts
  - id: clinvar_tx_acc_counts
    type: File
    doc: "Path to txAcc to count mapping"
    inputBinding:
      position: 7
      prefix: --clinvar-tx-acc-counts
  - id: output
    type: string
    doc: "Path to the output TSV file"
    inputBinding:
      position: 8
      prefix: --output
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase logging verbosity"
    inputBinding:
      position: 9
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Decrease logging verbosity"
    inputBinding:
      position: 10
      prefix: --quiet
outputs:
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: "Check report TSV file"
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
stdout: mehari_db_check.out
