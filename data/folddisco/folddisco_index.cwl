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
    type:
      - Directory
      - File
    doc: Directory or Foldcomp DB containing PDB files. It is staged in the working directory and given by its relative name, because the index stores this path and folddisco query must find the structures under the same relative path (stage the same directory in the query too).
    inputBinding:
      position: 101
      prefix: --pdbs
      valueFrom: $(self.basename)
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
  - id: index_path_path
    type: string
    doc: Path to save the index table
    inputBinding:
      position: 102
      prefix: --index
outputs:
  - id: index_path
    type: File
    doc: Index table; the .lookup, .offset and .type files are secondary files
    outputBinding:
      glob: $(inputs.index_path_path)
    secondaryFiles:
      - .lookup
      - .offset
      - .type
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.pdbs_dir_or_db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/folddisco:1.7514114--ha6fb395_0
