cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genrestr
label: biobb_gromacs_genrestr
doc: "Wrapper for the GROMACS genrestr module.\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Properties file. This file can be a YAML file, JSON file or JSON string
    inputBinding:
      position: 1
      prefix: --config
  - id: input_structure_path
    type: File
    doc: 'Path to the input structure PDB, GRO or TPR format. Accepted formats: pdb, gro, tpr.'
    inputBinding:
      position: 1
      prefix: --input_structure_path
  - id: output_itp_path
    type: string
    doc: 'Path the output ITP topology file with restrains. Accepted formats: itp.'
    default: genrestr.itp
    inputBinding:
      position: 1
      prefix: --output_itp_path
  - id: input_ndx_path
    type:
      - 'null'
      - File
    doc: 'Path to the input GROMACS index file, NDX format. Accepted formats: ndx.'
    inputBinding:
      position: 1
      prefix: --input_ndx_path
outputs:
  - id: itp
    type: File
    doc: 'Path the output ITP topology file with restrains. Accepted formats: itp.'
    outputBinding:
      glob: $(inputs.output_itp_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
