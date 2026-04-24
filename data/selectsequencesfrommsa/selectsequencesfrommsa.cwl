cwlVersion: v1.2
class: CommandLineTool
baseCommand: selectsequencesfrommsa
label: selectsequencesfrommsa
doc: "Selects sequences from a multiple sequence alignment based on a list of sequence
  identifiers.\n\nTool homepage: https://github.com/eggzilla/SelectSequencesFromMSA"
inputs:
  - id: input_msa
    type: File
    doc: Input multiple sequence alignment file (e.g., FASTA, PHYLIP).
    inputBinding:
      position: 1
  - id: sequence_ids
    type:
      type: array
      items: string
    doc: File containing a list of sequence identifiers to select, one per line.
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: Output format for the selected sequences (e.g., fasta, phylip).
    inputBinding:
      position: 103
      prefix: --format
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case when matching sequence identifiers.
    inputBinding:
      position: 103
      prefix: --ignore-case
  - id: invert_selection
    type:
      - 'null'
      - boolean
    doc: Invert the selection, i.e., select sequences NOT in the provided list.
    inputBinding:
      position: 103
      prefix: --invert
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for the selected sequences. If not specified, output will 
      be to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/selectsequencesfrommsa:1.0.5--pl526h9ebf644_0
