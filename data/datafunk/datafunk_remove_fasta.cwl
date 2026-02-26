cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - remove_fasta
label: datafunk_remove_fasta
doc: "Removes sequences from a FASTA file based on a filter file.\n\nTool homepage:
  https://github.com/cov-ert/datafunk"
inputs:
  - id: input_fasta
    type: File
    doc: The input FASTA file.
    inputBinding:
      position: 1
  - id: filter_file
    type: File
    doc: A file containing sequences to remove. Each line should be a sequence 
      ID.
    inputBinding:
      position: 102
      prefix: --filter_file
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: The output FASTA file. If not provided, results will be printed to 
      stdout.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
