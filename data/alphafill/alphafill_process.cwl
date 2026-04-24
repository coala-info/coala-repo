cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alphafill
  - process
label: alphafill_process
doc: "Process AlphaFold models to fill them with ligands and other missing structural
  information.\n\nTool homepage: https://alphafill.eu"
inputs:
  - id: input_file
    type: File
    doc: Input file (AlphaFold model)
    inputBinding:
      position: 1
  - id: blast_report_limit
    type:
      - 'null'
      - int
    doc: Number of blast hits to use
    inputBinding:
      position: 102
      prefix: --blast-report-limit
  - id: clash_distance_cutoff
    type:
      - 'null'
      - float
    doc: The max distance between polymer atoms and ligand atoms used in calculating
      clash scores
    inputBinding:
      position: 102
      prefix: --clash-distance-cutoff
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file to use
    inputBinding:
      position: 102
      prefix: --config
  - id: data_source
    type:
      - 'null'
      - string
    doc: Data source for input model
    inputBinding:
      position: 102
      prefix: --data-source
  - id: ligands
    type:
      - 'null'
      - File
    doc: File in CIF format describing the ligands and their modifications
    inputBinding:
      position: 102
      prefix: --ligands
  - id: max_ligand_to_backbone_distance
    type:
      - 'null'
      - float
    doc: The max distance to use to find neighbouring backbone atoms for the ligand
      in the AF structure
    inputBinding:
      position: 102
      prefix: --max-ligand-to-backbone-distance
  - id: max_ligand_to_polymer_atom_distance
    type:
      - 'null'
      - float
    doc: The max distance to use to find neighbouring polymer atoms for the ligand
      in the AF structure (for validation)
    inputBinding:
      position: 102
      prefix: --max-ligand-to-polymer-atom-distance
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: The minimal length of an alignment
    inputBinding:
      position: 102
      prefix: --min-alignment-length
  - id: min_hsp_identity
    type:
      - 'null'
      - float
    doc: The minimal identity for a high scoring pair (note, value between 0 and 1)
    inputBinding:
      position: 102
      prefix: --min-hsp-identity
  - id: min_separation_distance
    type:
      - 'null'
      - float
    doc: The centroids of two identical ligands should be at least this far apart
      to count as separate occurrences
    inputBinding:
      position: 102
      prefix: --min-separation-distance
  - id: pae_file
    type:
      - 'null'
      - File
    doc: Specify a specific file containing PAE information, default is to use a filename
      based on inputfile
    inputBinding:
      position: 102
      prefix: --pae-file
  - id: pdb_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the mmCIF files for the PDB
    inputBinding:
      position: 102
      prefix: --pdb-dir
  - id: pdb_fasta
    type:
      - 'null'
      - File
    doc: The FastA file containing the PDB sequences
    inputBinding:
      position: 102
      prefix: --pdb-fasta
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not produce warnings or status messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, zero means all available cores
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alphafill:2.2.0--haf24da9_0
