cwlVersion: v1.2
class: CommandLineTool
baseCommand: smina
label: smina
doc: "smina is a fork of AutoDock Vina that is customized to better support scoring
  function development and high-performance docking.\n\nTool homepage: https://sourceforge.net/projects/smina/"
inputs:
  - id: autobox_add
    type:
      - 'null'
      - float
    doc: Amount of buffer to add to the auto-generated box (Angstroms)
    inputBinding:
      position: 101
      prefix: --autobox_add
  - id: autobox_ligand
    type:
      - 'null'
      - File
    doc: Automatically set the search box around the provided ligand file
    inputBinding:
      position: 101
      prefix: --autobox_ligand
  - id: center_x
    type:
      - 'null'
      - float
    doc: X coordinate of the center of the search box
    inputBinding:
      position: 101
      prefix: --center_x
  - id: center_y
    type:
      - 'null'
      - float
    doc: Y coordinate of the center of the search box
    inputBinding:
      position: 101
      prefix: --center_y
  - id: center_z
    type:
      - 'null'
      - float
    doc: Z coordinate of the center of the search box
    inputBinding:
      position: 101
      prefix: --center_z
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs to use (the default is to try to detect the number of 
      CPUs)
    inputBinding:
      position: 101
      prefix: --cpu
  - id: energy_range
    type:
      - 'null'
      - float
    doc: Maximum energy difference between the best binding mode and the worst 
      one displayed (kcal/mol)
    default: 3.0
    inputBinding:
      position: 101
      prefix: --energy_range
  - id: exhaustiveness
    type:
      - 'null'
      - int
    doc: Exhaustiveness of the global search (roughly proportional to time)
    default: 8
    inputBinding:
      position: 101
      prefix: --exhaustiveness
  - id: flexres
    type:
      - 'null'
      - File
    doc: Flexible side chains, if any (PDBQT)
    inputBinding:
      position: 101
      prefix: --flexres
  - id: ligand
    type: File
    doc: Ligand to dock (PDBQT)
    inputBinding:
      position: 101
      prefix: --ligand
  - id: no_vdw
    type:
      - 'null'
      - boolean
    doc: Disable van der Waals terms
    inputBinding:
      position: 101
      prefix: --no_vdw
  - id: num_modes
    type:
      - 'null'
      - int
    doc: Maximum number of binding modes to generate
    default: 9
    inputBinding:
      position: 101
      prefix: --num_modes
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output messages
    inputBinding:
      position: 101
      prefix: --quiet
  - id: receptor
    type: File
    doc: Rigid part of the receptor (PDBQT)
    inputBinding:
      position: 101
      prefix: --receptor
  - id: scoring
    type:
      - 'null'
      - string
    doc: Specify the scoring function to use (e.g., vina, vinardo, dkoes_fast)
    inputBinding:
      position: 101
      prefix: --scoring
  - id: seed
    type:
      - 'null'
      - int
    doc: Explicit random seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: size_x
    type:
      - 'null'
      - float
    doc: Size of the search box in the X dimension (Angstroms)
    inputBinding:
      position: 101
      prefix: --size_x
  - id: size_y
    type:
      - 'null'
      - float
    doc: Size of the search box in the Y dimension (Angstroms)
    inputBinding:
      position: 101
      prefix: --size_y
  - id: size_z
    type:
      - 'null'
      - float
    doc: Size of the search box in the Z dimension (Angstroms)
    inputBinding:
      position: 101
      prefix: --size_z
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name, write to this file instead of standard output
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type:
      - 'null'
      - File
    doc: Optionally, write log file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smina:2017.11.9--0
