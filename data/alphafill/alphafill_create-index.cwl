cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alphafill
  - create-index
label: alphafill_create-index
doc: "Create an index for AlphaFill using PDB mmCIF files and sequences\n\nTool homepage:
  https://alphafill.eu"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file to use
    inputBinding:
      position: 101
      prefix: --config
  - id: pdb_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the mmCIF files for the PDB
    inputBinding:
      position: 101
      prefix: --pdb-dir
  - id: pdb_fasta
    type:
      - 'null'
      - File
    doc: The FastA file containing the PDB sequences
    inputBinding:
      position: 101
      prefix: --pdb-fasta
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not produce warnings or status messages
    inputBinding:
      position: 101
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, zero means all available cores
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alphafill:2.2.0--haf24da9_0
stdout: alphafill_create-index.out
