cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MetaCHIP
  - rename_seqs
label: metachip_rename_seqs
doc: "Rename sequences in a fasta file. The result is written beside the input as
  <name>_renamed.<ext>.\n\nTool homepage: https://github.com/songweizhi/MetaCHIP"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
inputs:
  - id: input_file
    type: File
    doc: input sequence file
    inputBinding:
      prefix: -in
  - id: inc_suffix
    type: ['null', boolean]
    doc: rename sequences by incrementally adding suffix to file name
    inputBinding:
      prefix: -inc_suffix
  - id: sep_in
    type: ['null', string]
    doc: separator for input sequences
    inputBinding:
      prefix: -sep_in
  - id: sep_out
    type: ['null', string]
    doc: 'separator for output sequences, default: same as sep_in'
    inputBinding:
      prefix: -sep_out
  - id: n_columns
    type: ['null', int]
    doc: the number of columns to keep
    inputBinding:
      prefix: -n
  - id: prefix
    type: ['null', string]
    doc: add prefix to sequence
    inputBinding:
      prefix: -prefix
  - id: extension
    type: ['null', string]
    doc: file extension
    inputBinding:
      prefix: -x
outputs:
  - id: renamed
    type: File
    doc: renamed sequence file
    outputBinding:
      glob: "$(inputs.input_file.nameroot)_renamed$(inputs.input_file.nameext)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
