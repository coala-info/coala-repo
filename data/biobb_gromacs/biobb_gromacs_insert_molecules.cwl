cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_gromacs_insert_molecules
label: biobb_gromacs_insert_molecules
doc: "A wrapper of the GROMACS insert-molecules module. The GROMACS insert-molecules
  tool inserts a number of copies of a molecule into a given structure.\n\nTool homepage:
  https://github.com/bioexcel/biobb_gromacs"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: input_mask_path
    type:
      - 'null'
      - File
    doc: Path to the input mask file
    inputBinding:
      position: 101
      prefix: --input_mask_path
  - id: input_nmol_path
    type: File
    doc: Path to the input molecule to be inserted
    inputBinding:
      position: 101
      prefix: --input_nmol_path
  - id: input_structure_path
    type: File
    doc: Path to the input structure file
    inputBinding:
      position: 101
      prefix: --input_structure_path
outputs:
  - id: output_structure_path
    type: File
    doc: Path to the output structure file
    outputBinding:
      glob: $(inputs.output_structure_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
