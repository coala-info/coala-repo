cwlVersion: v1.2
class: CommandLineTool
baseCommand: alphafold
label: biobb_io_alphafold
doc: "The biobb_io_alphafold tool fetches a PDB file from the AlphaFold Protein Structure
  Database using a UniProt ID.\n\nTool homepage: https://github.com/bioexcel/biobb_io"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file for the tool
    inputBinding:
      position: 101
      prefix: --config
  - id: uniprot_id
    type: string
    doc: UniProt ID of the protein structure to be fetched
    inputBinding:
      position: 101
      prefix: --uniprot_id
outputs:
  - id: output_pdb_path
    type: File
    doc: Path to the output PDB file
    outputBinding:
      glob: $(inputs.output_pdb_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_io:5.2.2--pyhdfd78af_0
