cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur_rename.seqs
doc: "Rename sequences in a FASTA file.\n\nTool homepage: https://www.mothur.org"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file containing sequences to rename.
    inputBinding:
      position: 1
  - id: name_file
    type:
      - 'null'
      - File
    doc: 'A file containing the current names and the new names for the sequences.
      The file should have two columns separated by a tab: current_name new_name.'
    inputBinding:
      position: 102
      prefix: --name
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: The name of the output FASTA file with renamed sequences.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
