cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - augur
  - titers
  - sub
label: augur_titers_sub
doc: "Annotate titer drops onto substitutions with the substitution titer model.\n\
  \nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: titers
    type:
      type: array
      items: File
    doc: file with titer measurements
    inputBinding:
      position: 1
      prefix: --titers
  - id: alignment
    type:
      type: array
      items: File
    doc: sequence to be used in the substitution model, supplied as fasta files
    inputBinding:
      position: 1
      prefix: --alignment
  - id: gene_names
    type:
      type: array
      items: string
    doc: names of the sequences in the alignment, same order assumed
    inputBinding:
      position: 1
      prefix: --gene-names
  - id: tree
    type:
      - 'null'
      - File
    doc: optional tree to annotate fit titer model to
    inputBinding:
      position: 1
      prefix: --tree
  - id: allow_empty_model
    type:
      - 'null'
      - boolean
    doc: allow model to be empty
    inputBinding:
      position: 1
      prefix: --allow-empty-model
  - id: attribute_prefix
    type:
      - 'null'
      - string
    doc: prefix for node attributes in the JSON output including cumulative titer
      drop ('cTiterSub') and per- substitution titer drop ('dTiterSub'). Set a prefix
      to disambiguate annotations from multiple substitution model JSONs in the final
      Auspice JSON.
    inputBinding:
      position: 1
      prefix: --attribute-prefix
  - id: output
    type: string
    doc: JSON file to save titer model
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: JSON file with the titer model.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
