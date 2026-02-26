cwlVersion: v1.2
class: CommandLineTool
baseCommand: datafunk phylotype_consensus
label: datafunk_phylotype_consensus
doc: "Splits a fasta file into phylotypes based on metadata and clade definitions,
  and generates consensus sequences.\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: clade_file
    type: File
    doc: Clade file stating the phylotypes needed to be grouped
    inputBinding:
      position: 101
      prefix: --clade-file
  - id: input_fasta
    type: File
    doc: Fasta file for splitting into phylotypes
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: input_metadata
    type: File
    doc: Input metadata (csv) with phylotype information
    inputBinding:
      position: 101
      prefix: --input-metadata
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run with high verbosity (debug level logging)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_folder
    type: Directory
    doc: Output folder for the phylotype fasta files and consensus file
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
