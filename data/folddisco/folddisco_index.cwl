cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - folddisco
  - index
label: folddisco_index
doc: "Index PDB files for folddisco\n\nTool homepage: https://github.com/steineggerlab/folddisco"
inputs:
  - id: angle_bins
    type:
      - 'null'
      - int
    doc: Number of angle bins
    inputBinding:
      position: 101
      prefix: --angle
  - id: distance_bins
    type:
      - 'null'
      - int
    doc: Number of distance bins
    inputBinding:
      position: 101
      prefix: --distance
  - id: hash_type
    type:
      - 'null'
      - string
    doc: Hash type to use
    inputBinding:
      position: 101
      prefix: --type
  - id: id_type
    type:
      - 'null'
      - string
    doc: ID type to use (pdb, uniprot, afdb, relpath, abspath)
    inputBinding:
      position: 101
      prefix: --id
  - id: max_residue
    type:
      - 'null'
      - int
    doc: Maximum number of residues in a PDB file
    inputBinding:
      position: 101
      prefix: --max-residue
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode to index
    inputBinding:
      position: 101
      prefix: --mode
  - id: multiple_bins
    type:
      - 'null'
      - string
    doc: Multiple bins for distance and angle (dist1-ang1,dist2-ang2 e.g. 
      16-4,8-3)
    inputBinding:
      position: 101
      prefix: --multiple-bins
  - id: pdbs_dir_or_db
    type: File
    doc: Directory or Foldcomp DB containing PDB files
    inputBinding:
      position: 101
      prefix: --pdbs
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Index PDB files in subdirectories recursively
    inputBinding:
      position: 101
      prefix: --recursive
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose messages
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: index_path
    type: Directory
    doc: Path to save the index table
    outputBinding:
      glob: $(inputs.index_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/folddisco:1.7514114--ha6fb395_0
