cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SelectSequencesFromMSA
label: selectsequencesfrommsa
doc: "Selects a representative subset of sequences from a multiple sequence alignment
  in Clustal format. Inspired by the SelectSequences.pl script of RNAz.\n\nTool homepage:
  https://github.com/eggzilla/SelectSequencesFromMSA"
inputs:
  - id: input_clustal
    type: File
    doc: Path to input clustal file
    inputBinding:
      position: 1
      prefix: -c
  - id: output_path
    type:
      - 'null'
      - string
    doc: Path to output directory. Default current working directory
    inputBinding:
      position: 1
      prefix: -o
  - id: output_filename
    type: string
    default: results.selected
    doc: Output filename
    inputBinding:
      position: 1
      prefix: -f
  - id: toggle_external_selectsequences
    type:
      - 'null'
      - boolean
    doc: Use only replacement of alignment characters and external 'selectSequence.pl'
    inputBinding:
      position: 1
      prefix: -e
  - id: sequence_number
    type:
      - 'null'
      - int
    doc: Number of sequences in the output alignment. (Default 6)
    inputBinding:
      position: 1
      prefix: -n
  - id: optimal_identity
    type:
      - 'null'
      - float
    doc: Optimize for this percentage of mean pairwise identity (Default 80)
    inputBinding:
      position: 1
      prefix: -i
  - id: maximal_identity
    type:
      - 'null'
      - float
    doc: Sequences with a higher percentage of pairwise Identity will be removed.
      (Default 95)
    inputBinding:
      position: 1
      prefix: -m
  - id: reference_sequence
    type:
      - 'null'
      - boolean
    doc: The first sequence (=reference sequence) is always present in the output
      alignment per default
    inputBinding:
      position: 1
      prefix: -x
  - id: distance_matrix_path
    type:
      - 'null'
      - string
    doc: Path to distance matrix output file, only internal for internal sequence
      selection, e.g. /home/user/distmat
    inputBinding:
      position: 1
      prefix: -d
  - id: reformat_id_option
    type:
      - 'null'
      - string
    doc: Defines how sequence id is reformated, e.g. fitting for RNAcode or not
      (Default RNAcode)
    inputBinding:
      position: 1
      prefix: -r
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Loud verbosity
    inputBinding:
      position: 1
      prefix: -v
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet verbosity
    inputBinding:
      position: 1
      prefix: -q
outputs:
  - id: selected_alignment
    type: File
    doc: Selected sequences as a Clustal alignment
    outputBinding:
      glob: "$(inputs.output_path ? inputs.output_path + '/' + inputs.output_filename : inputs.output_filename)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/selectsequencesfrommsa:1.0.5--pl526h9ebf644_0
