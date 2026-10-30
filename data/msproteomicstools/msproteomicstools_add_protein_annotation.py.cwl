cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - add_protein_annotation.py
label: msproteomicstools_add_protein_annotation.py
doc: "Annotate a csv with protein descriptions from FASTA. It searches for a column named ProteinName, looks it up in the FASTA file and adds a column ProteinDescription to the csv.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: fasta_file
    type: File
    doc: "A fasta file"
    inputBinding:
      prefix: --fasta
  - id: mprophet_file
    type: File
    doc: "A mProphet output file"
    inputBinding:
      prefix: --in
  - id: output_path
    type: string
    doc: "A modified mProphet output file"
    inputBinding:
      prefix: --out
outputs:
  - id: output
    type: File
    doc: "Annotated table"
    outputBinding:
      glob: "$(inputs.output_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
