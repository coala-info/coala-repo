cwlVersion: v1.2
class: CommandLineTool
baseCommand: vina
label: autodock-vina_vina
doc: "AutoDock Vina is a molecular docking program for drug discovery, molecular docking
  and virtual screening.\n\nTool homepage: https://github.com/ccsb-scripps/AutoDock-Vina"
inputs:
  - id: center_x
    type: float
    doc: X coordinate of the center
    inputBinding:
      position: 101
      prefix: --center_x
  - id: center_y
    type: float
    doc: Y coordinate of the center
    inputBinding:
      position: 101
      prefix: --center_y
  - id: center_z
    type: float
    doc: Z coordinate of the center
    inputBinding:
      position: 101
      prefix: --center_z
  - id: config
    type:
      - 'null'
      - File
    doc: the above options can be put here
    inputBinding:
      position: 101
      prefix: --config
  - id: cpu
    type:
      - 'null'
      - int
    doc: the number of CPUs to use (the default is to try to detect the number of
      CPUs or, failing that, use 1)
    inputBinding:
      position: 101
      prefix: --cpu
  - id: energy_range
    type:
      - 'null'
      - float
    doc: maximum energy difference between the best binding mode and the worst one
      displayed (kcal/mol)
    inputBinding:
      position: 101
      prefix: --energy_range
  - id: exhaustiveness
    type:
      - 'null'
      - int
    doc: 'exhaustiveness of the global search (roughly proportional to time): 1+'
    inputBinding:
      position: 101
      prefix: --exhaustiveness
  - id: flex
    type:
      - 'null'
      - File
    doc: flexible side chains, if any (PDBQT)
    inputBinding:
      position: 101
      prefix: --flex
  - id: help_advanced
    type:
      - 'null'
      - boolean
    doc: display usage summary with advanced options
    inputBinding:
      position: 101
      prefix: --help_advanced
  - id: ligand
    type:
      - 'null'
      - File
    doc: ligand (PDBQT)
    inputBinding:
      position: 101
      prefix: --ligand
  - id: num_modes
    type:
      - 'null'
      - int
    doc: maximum number of binding modes to generate
    inputBinding:
      position: 101
      prefix: --num_modes
  - id: receptor
    type:
      - 'null'
      - File
    doc: rigid part of the receptor (PDBQT)
    inputBinding:
      position: 101
      prefix: --receptor
  - id: seed
    type:
      - 'null'
      - int
    doc: explicit random seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: size_x
    type: float
    doc: size in the X dimension (Angstroms)
    inputBinding:
      position: 101
      prefix: --size_x
  - id: size_y
    type: float
    doc: size in the Y dimension (Angstroms)
    inputBinding:
      position: 101
      prefix: --size_y
  - id: size_z
    type: float
    doc: size in the Z dimension (Angstroms)
    inputBinding:
      position: 101
      prefix: --size_z
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output models (PDBQT), the default is chosen based on the ligand file name
    outputBinding:
      glob: $(inputs.out)
  - id: log
    type:
      - 'null'
      - File
    doc: optionally, write log file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/autodock-vina:v1.1.2-3b6-deb_cv1
