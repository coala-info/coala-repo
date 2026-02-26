cwlVersion: v1.2
class: CommandLineTool
baseCommand: cojac_cooc-pubmut
label: cojac_cooc-pubmut
doc: "Calculates co-occurrence of mutations in published datasets.\n\nTool homepage:
  https://github.com/cbg-ethz/cojac"
inputs:
  - id: input_table
    type: File
    doc: Path to the input table (e.g., CSV, TSV) containing mutation data.
    inputBinding:
      position: 1
  - id: gene_col
    type:
      - 'null'
      - string
    doc: Name of the column containing gene identifiers (optional).
    default: gene
    inputBinding:
      position: 102
      prefix: --gene-col
  - id: min_cooccurrence
    type:
      - 'null'
      - int
    doc: Minimum number of co-occurrences required for a mutation pair.
    default: 1
    inputBinding:
      position: 102
      prefix: --min-cooccurrence
  - id: min_samples
    type:
      - 'null'
      - int
    doc: Minimum number of samples required for a mutation pair to be 
      considered.
    default: 2
    inputBinding:
      position: 102
      prefix: --min-samples
  - id: mutation_col
    type:
      - 'null'
      - string
    doc: Name of the column containing mutation identifiers.
    default: mutation
    inputBinding:
      position: 102
      prefix: --mutation-col
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save the output files.
    default: .
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: sample_col
    type:
      - 'null'
      - string
    doc: Name of the column containing sample identifiers.
    default: sample_id
    inputBinding:
      position: 102
      prefix: --sample-col
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cojac:0.9.3--pyh7e72e81_0
stdout: cojac_cooc-pubmut.out
