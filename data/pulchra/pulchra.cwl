cwlVersion: v1.2
class: CommandLineTool
baseCommand: pulchra
label: pulchra
doc: "PULCHRA Protein Chain Restoration Algorithm. The program default input is a
  PDB file. Output file <pdb_file.rebuild.pdb> will be created as a result.\n\nTool
  homepage: https://www.pirx.com/pulchra/"
inputs:
  - id: pdb_file
    type: File
    doc: Input PDB file
    inputBinding:
      position: 1
  - id: center_chain
    type:
      - 'null'
      - boolean
    doc: 'center chain (default: off)'
    inputBinding:
      position: 102
      prefix: -n
  - id: detect_cis_prolins
    type:
      - 'null'
      - boolean
    doc: 'detect cis-prolins (default: off)'
    inputBinding:
      position: 102
      prefix: -p
  - id: initial_calpha_pdb
    type:
      - 'null'
      - File
    doc: read the initial C-alpha coordinates from a PDB file
    inputBinding:
      position: 102
      prefix: -i
  - id: max_shift
    type:
      - 'null'
      - float
    doc: 'maximum shift from the restraint coordinates (default: 0.5A)'
    default: 0.5
    inputBinding:
      position: 102
      prefix: -u
  - id: no_check_chirality
    type:
      - 'null'
      - boolean
    doc: "don't check amino acid chirality (default: on)"
    inputBinding:
      position: 102
      prefix: -z
  - id: no_fix_conflicts
    type:
      - 'null'
      - boolean
    doc: "don't attempt to fix excluded volume conflicts (default: on)"
    inputBinding:
      position: 102
      prefix: -o
  - id: optimize_h_bonds
    type:
      - 'null'
      - boolean
    doc: 'optimize backbone hydrogen bonds pattern (default: off)'
    inputBinding:
      position: 102
      prefix: -q
  - id: output_hydrogen
    type:
      - 'null'
      - boolean
    doc: 'outputs hydrogen atoms (default: off)'
    inputBinding:
      position: 102
      prefix: -h
  - id: preserve_coordinates
    type:
      - 'null'
      - boolean
    doc: "preserve initial coordinates (default: off, implies '-c' on and '-n' off)"
    inputBinding:
      position: 102
      prefix: -f
  - id: random_chain
    type:
      - 'null'
      - boolean
    doc: 'start from a random chain (default: off)'
    inputBinding:
      position: 102
      prefix: -r
  - id: rearrange_backbone
    type:
      - 'null'
      - boolean
    doc: 'rearrange backbone atoms (C, O are output after side chain) (default: off)'
    inputBinding:
      position: 102
      prefix: -e
  - id: save_trajectory
    type:
      - 'null'
      - boolean
    doc: save chain optimization trajectory to file <pdb_file.pdb.trajectory>
    inputBinding:
      position: 102
      prefix: -t
  - id: skip_backbone_reconstruction
    type:
      - 'null'
      - boolean
    doc: 'skip backbone reconstruction (default: on)'
    inputBinding:
      position: 102
      prefix: -b
  - id: skip_calpha_optimization
    type:
      - 'null'
      - boolean
    doc: 'skip C-alpha positions optimization (default: on)'
    inputBinding:
      position: 102
      prefix: -c
  - id: skip_side_chains
    type:
      - 'null'
      - boolean
    doc: 'skip side chains reconstruction (default: on)'
    inputBinding:
      position: 102
      prefix: -s
  - id: time_seed
    type:
      - 'null'
      - boolean
    doc: 'time-seed random number generator (default: off)'
    inputBinding:
      position: 102
      prefix: -x
  - id: use_pdbsg
    type:
      - 'null'
      - boolean
    doc: use PDBSG as an input format (CA=C-alpha, SC or CM=side chain c.m.)
    inputBinding:
      position: 102
      prefix: -g
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'verbose output (default: off)'
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pulchra:3.06--h031d066_4
stdout: pulchra.out
