cwlVersion: v1.2
class: CommandLineTool
baseCommand: concavity
label: concavity
doc: "Predict protein ligand binding sites from structure and conservation.\n\nTool
  homepage: https://github.com/mlichter2/concavity"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: pdb_file
    type: File
    doc: Input PDB file
    inputBinding:
      position: 2
  - id: output_name
    type: string
    doc: Name that becomes part of the output file names (may not contain "/"). 
      Output is written to the current directory.
    inputBinding:
      position: 3
  - id: conservation_dir
    type:
      - 'null'
      - Directory
    doc: Folder with the per-chain conservation files (<prefix>_<chain>_jsd.scores)
  - id: conservation_prefix
    type:
      - 'null'
      - string
    doc: Prefix of the per-chain conservation files inside conservation_dir (e.g.
      1G6C). If not given, conservation information is not considered.
    inputBinding:
      position: 1
      prefix: -conservation
      valueFrom: "$(inputs.conservation_dir ? inputs.conservation_dir.path + '/' + self
        : self)"
  - id: grid_method
    type:
      - 'null'
      - string
    doc: 'Grid creation method: ligsite, surfnet, pocketfinder or custom'
    inputBinding:
      position: 1
      prefix: -grid_method
  - id: resolution
    type:
      - 'null'
      - type: array
        items: int
    doc: Set the grid resolution (three integers)
    inputBinding:
      position: 1
      prefix: -resolution
  - id: spacing
    type:
      - 'null'
      - float
    doc: Set the grid spacing.
    inputBinding:
      position: 1
      prefix: -spacing
  - id: extraction_method
    type:
      - 'null'
      - string
    doc: 'Pocket extraction method: search, topn or custom'
    inputBinding:
      position: 1
      prefix: -extraction_method
  - id: extraction_threshold_range_cutoff
    type:
      - 'null'
      - double
    doc: Stop the iterative search method when the diameter of the binary search
      window is less than this value * upper_threshold. Recommended value 1e-6. 
      Default 0.
    inputBinding:
      position: 1
      prefix: -extraction_threshold_range_cutoff
  - id: res_map_method
    type:
      - 'null'
      - string
    doc: 'Residue mapping method: blur, dist, dist-thresh or custom'
    inputBinding:
      position: 1
      prefix: -res_map_method
  - id: print_grid_dx
    type:
      - 'null'
      - int
    doc: Write pocket prediction grid values in DX format (0 or 1). This is 1 by
      default.
    inputBinding:
      position: 1
      prefix: -print_grid_dx
  - id: print_grid_pdb
    type:
      - 'null'
      - int
    doc: Write pocket prediction grid values in PDB format (0 or 1).
    inputBinding:
      position: 1
      prefix: -print_grid_pdb
  - id: print_grid_txt
    type:
      - 'null'
      - int
    doc: Write pocket prediction grid values as raw text (0 or 1).
    inputBinding:
      position: 1
      prefix: -print_grid_txt
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 1
      prefix: -v
outputs:
  - id: chain_scores
    type:
      type: array
      items: File
    doc: Residue ligand binding predictions for each chain
    outputBinding:
      glob: '*_$(inputs.output_name).scores'
  - id: residue_pdb
    type: File
    doc: Residue ligand binding predictions in PDB format (residue scores in the
      temperature factor field)
    outputBinding:
      glob: '*_$(inputs.output_name)_residue.pdb'
  - id: grid_dx
    type:
      - 'null'
      - File
    doc: Pocket prediction locations in DX format
    outputBinding:
      glob: '*_$(inputs.output_name).dx'
  - id: pymol_script
    type:
      - 'null'
      - File
    doc: PyMOL script to visualize the predictions
    outputBinding:
      glob: '*_$(inputs.output_name).pml'
  - id: grid_pdb
    type:
      - 'null'
      - File
    doc: Pocket prediction grid values in PDB format (with -print_grid_pdb 1)
    outputBinding:
      glob: '*_$(inputs.output_name)_pocket.pdb'
  - id: grid_txt
    type:
      - 'null'
      - File
    doc: Pocket prediction grid values as raw text (with -print_grid_txt 1)
    outputBinding:
      glob: '*_$(inputs.output_name).grdtxt'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/concavity:v0.1dfsg.1-4-deb_cv1
