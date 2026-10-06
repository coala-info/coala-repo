cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - architeuthis
  - mapping
  - score
label: architeuthis_mapping_score
doc: "Scores and evaluates reads.\n\nTool homepage: https://github.com/cdiener/architeuthis"
inputs:
  - id: kraken_output
    type: File
    doc: Kraken2 read-level output file.
    inputBinding:
      position: 10
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: The path to the taxonomy dumps (NCBI taxdump folder with names.dmp and nodes.dmp).
    inputBinding:
      position: 1
      prefix: --data-dir
  - id: format
    type:
      - 'null'
      - string
    doc: The taxonomic ranks to consider during scoring. (default "d__{domain|acellularroot|superkingdom};p__{phylum};c__{class};o__{order};f__{family};g__{genus};s__{species}")
    inputBinding:
      position: 1
      prefix: --format
  - id: out
    type: string
    doc: The output file (CSV format). (default "mapping_scores.csv")
    inputBinding:
      position: 1
      prefix: --out
    default: mapping_scores.csv
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
    doc: CSV of per-read scores (consistency, confidence, multiplicity, entropy).
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
