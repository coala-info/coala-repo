cwlVersion: v1.2
class: CommandLineTool
baseCommand: MMPBSA.py
label: ambertools_MMPBSA.py
doc: "MMPBSA.py calculates binding free energies using end-state free energy methods
  like MM-PBSA and MM-GBSA.\n\nTool homepage: https://github.com/quantaosun/Ambertools-OpenMM-MD"
inputs:
  - id: complex_prmtop
    type: File
    doc: Complex topology file.
    inputBinding:
      position: 101
      prefix: -cp
  - id: input_file
    type: File
    doc: MMPBSA.py input file containing variables for the calculation.
    inputBinding:
      position: 101
      prefix: -i
  - id: ligand_prmtop
    type:
      - 'null'
      - File
    doc: Ligand topology file.
    inputBinding:
      position: 101
      prefix: -lp
  - id: no_gui
    type:
      - 'null'
      - boolean
    doc: Do not use the GUI.
    inputBinding:
      position: 101
      prefix: -nogui
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output files.
    inputBinding:
      position: 101
      prefix: -O
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for intermediate files.
    inputBinding:
      position: 101
      prefix: -prefix
  - id: receptor_prmtop
    type:
      - 'null'
      - File
    doc: Receptor topology file.
    inputBinding:
      position: 101
      prefix: -rp
  - id: solvated_prmtop
    type:
      - 'null'
      - File
    doc: Solvated complex topology file.
    inputBinding:
      position: 101
      prefix: -sp
  - id: trajectories
    type:
      - 'null'
      - type: array
        items: File
    doc: Trajectory file(s) to analyze.
    inputBinding:
      position: 101
      prefix: -y
  - id: use_mdins
    type:
      - 'null'
      - boolean
    doc: Use existing mdin files instead of generating them.
    inputBinding:
      position: 101
      prefix: -use-mdins
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file with the calculated energy values.
    outputBinding:
      glob: $(inputs.output_file)
  - id: decomp_output
    type:
      - 'null'
      - File
    doc: Output file for decomposition analysis.
    outputBinding:
      glob: $(inputs.decomp_output)
  - id: csv_output
    type:
      - 'null'
      - File
    doc: CSV output file for spreadsheet programs.
    outputBinding:
      glob: $(inputs.csv_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ambertools:21.10
