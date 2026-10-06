cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - architeuthis
  - mapping
  - kmers
label: architeuthis_mapping_kmers
doc: "Summarize k-mer assignments for classified taxa.\n\nTool homepage: https://github.com/cdiener/architeuthis"
inputs:
  - id: kraken_output
    type: File
    doc: Kraken2 read-level output file.
    inputBinding:
      position: 10
  - id: out
    type: string
    doc: The output file (CSV format). (default "mapping_kmers.csv")
    inputBinding:
      position: 1
      prefix: --out
    default: mapping_kmers.csv
  - id: db
    type:
      - 'null'
      - Directory
    doc: path to the Kraken database [optional]
    inputBinding:
      position: 1
      prefix: --db
outputs:
  - id: output
    type: File
    doc: CSV of k-mer assignments per final classification.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
