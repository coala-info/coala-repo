cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-create-sequence-dictionary
label: dsh-bio_create-sequence-dictionary
doc: "Creates a sequence dictionary from a FASTA file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fasta_path
    type:
      - 'null'
      - File
    doc: input FASTA path, default stdin
    inputBinding:
      position: 101
      prefix: --input-fasta-path
  - id: url
    type:
      - 'null'
      - string
    doc: URL, default input FASTA path
    inputBinding:
      position: 101
      prefix: --url
outputs:
  - id: output_sequence_dictionary_file
    type:
      - 'null'
      - File
    doc: output SequenceDictionary .dict file, default stdout
    outputBinding:
      glob: $(inputs.output_sequence_dictionary_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
