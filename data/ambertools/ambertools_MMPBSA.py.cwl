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
  - id: csv_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `csv_output_path`
    inputBinding:
      position: 102
      prefix: --csv-output
  - id: decomp_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `decomp_output_path`
    inputBinding:
      position: 103
      prefix: --decomp-output
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 104
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file with the calculated energy values.
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: decomp_output
    type:
      - 'null'
      - File
    doc: Output file for decomposition analysis.
    outputBinding:
      glob: $(inputs.decomp_output_path)
  - id: csv_output
    type:
      - 'null'
      - File
    doc: CSV output file for spreadsheet programs.
    outputBinding:
      glob: $(inputs.csv_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ambertools:21.10
