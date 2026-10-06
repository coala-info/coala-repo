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
    doc: Configuration file for the tool (YAML or JSON). Give this or uniprot_code.
    inputBinding:
      position: 101
      prefix: --config
  - id: uniprot_code
    type:
      - 'null'
      - string
    doc: UniProt code of the protein structure to fetch (property uniprot_code, passed
      as a JSON config string). Give this or config.
    inputBinding:
      position: 101
      prefix: --config
      valueFrom: '$(JSON.stringify({properties: {uniprot_code: self}}))'
  - id: output_pdb_path
    type: string
    doc: 'Path to the output PDB file. Accepted formats: pdb.'
    inputBinding:
      position: 102
      prefix: --output_pdb_path
outputs:
  - id: output_pdb
    type: File
    doc: Output PDB file
    outputBinding:
      glob: $(inputs.output_pdb_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_io:5.2.2--pyhdfd78af_0
