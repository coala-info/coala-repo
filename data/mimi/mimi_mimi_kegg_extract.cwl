cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimi_kegg_extract
label: mimi_mimi_kegg_extract
doc: "Extract compound information (chemical formula, ID, name) from KEGG within a mass range.\n\nTool\
  \ homepage: https://github.com/NYUAD-Core-Bioinformatics/MIMI"
inputs:
  - id: min_mass
    type:
      - 'null'
      - double
    doc: Lower bound of molecular weight in Da.
    inputBinding:
      position: 101
      prefix: --min-mass
  - id: max_mass
    type:
      - 'null'
      - double
    doc: Upper bound of molecular weight in Da.
    inputBinding:
      position: 101
      prefix: --max-mass
  - id: input
    type:
      - 'null'
      - File
    doc: Input TSV file containing KEGG compound IDs.
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output TSV file path (default: kegg_compounds.tsv).'
    default: kegg_compounds.tsv
    inputBinding:
      position: 101
      prefix: --output
  - id: batch_size
    type:
      - 'null'
      - int
    doc: 'Number of compounds to process in each batch (default: 5).'
    inputBinding:
      position: 101
      prefix: --batch-size
outputs:
  - id: compounds
    type: File
    doc: Compound table.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
