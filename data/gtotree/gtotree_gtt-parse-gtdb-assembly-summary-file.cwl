cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-parse-gtdb-assembly-summary-file
label: gtotree_gtt-parse-gtdb-assembly-summary-file
doc: "Parses GTDB's assembly metadata file down to the target accessions.

Tool homepage: https://github.com/AstrobioMike/GToTree"
inputs:
  - id: assembly_summary
    type: File
    doc: "GTDB's assembly metadata file"
    inputBinding:
      position: 1
      prefix: -a
  - id: wanted_accessions
    type: File
    doc: "Single-column file with wanted accessions"
    inputBinding:
      position: 2
      prefix: -w
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Wanted summary info only"
    default: target-gtdb.tsv
    inputBinding:
      position: 3
      prefix: -o
  - id: found_accs_output_file
    type:
      - 'null'
      - string
    doc: "Accessions found in GTDB"
    default: gtdb-found-accs.txt
    inputBinding:
      position: 4
      prefix: -f
  - id: not_found_accs_output_file
    type:
      - 'null'
      - string
    doc: "Accessions not found in GTDB"
    default: gtdb-not-found-accs.tsv
    inputBinding:
      position: 5
      prefix: -n
  - id: gtdb_tax_output_file
    type:
      - 'null'
      - string
    doc: "Target GTDB taxonomy table"
    default: target-gtdb-tax.tsv
    inputBinding:
      position: 6
      prefix: -t
outputs:
  - id: wanted_summary
    type: File
    doc: "Summary info of the found accessions"
    outputBinding:
      glob: $(inputs.output_file)
  - id: found_accs
    type: File
    doc: "Accessions found in GTDB"
    outputBinding:
      glob: $(inputs.found_accs_output_file)
  - id: not_found_accs
    type:
      - 'null'
      - File
    doc: "Accessions not found in GTDB (written only when some are missing)"
    outputBinding:
      glob: $(inputs.not_found_accs_output_file)
  - id: gtdb_tax
    type: File
    doc: "Target GTDB taxonomy table"
    outputBinding:
      glob: $(inputs.gtdb_tax_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
