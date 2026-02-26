cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - merge_fasta
label: datafunk_merge_fasta
doc: "Merges multiple FASTA files into a single FASTA file based on a metadata file.\n\
  \nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: folder
    type: Directory
    doc: Directory containing the FASTA files to merge.
    inputBinding:
      position: 101
      prefix: --folder
  - id: input_metadata
    type: File
    doc: "Path to the metadata CSV file. The CSV file should contain at least two
      columns: 'filename' (referencing the FASTA files in the folder) and 'id' (the
      new identifier for the sequence)."
    inputBinding:
      position: 101
      prefix: --input-metadata
outputs:
  - id: output_fasta
    type: File
    doc: Path to the output merged FASTA file.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
