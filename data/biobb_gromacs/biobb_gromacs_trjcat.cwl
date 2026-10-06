cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - trjcat
label: biobb_gromacs_trjcat
doc: "Wrapper for the GROMACS trjcat module.\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Properties file. This file can be a YAML file, JSON file or JSON string
    inputBinding:
      position: 1
      prefix: --config
  - id: input_trj_zip_path
    type: File
    doc: 'Path the input GROMACS trajectories (xtc, trr, cpt, gro, pdb, tng) to concatenate in zip format. Accepted formats: zip.'
    inputBinding:
      position: 1
      prefix: --input_trj_zip_path
  - id: output_trj_path
    type: string
    doc: 'Path to the output trajectory file. Accepted formats: pdb, gro, xtc, trr, tng.'
    default: trjcat.trr
    inputBinding:
      position: 1
      prefix: --output_trj_path
outputs:
  - id: trj
    type: File
    doc: 'Path to the output trajectory file. Accepted formats: pdb, gro, xtc, trr, tng.'
    outputBinding:
      glob: $(inputs.output_trj_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
