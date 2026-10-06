cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - append_ligand
label: biobb_gromacs_append_ligand
doc: "This command takes a ligand ITP file and inserts it in a topology\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Properties file. This file can be a YAML file, JSON file or JSON string
    inputBinding:
      position: 1
      prefix: --config
  - id: input_top_zip_path
    type: File
    doc: 'Path the input topology TOP and ITP files zipball. Accepted formats: zip.'
    inputBinding:
      position: 1
      prefix: --input_top_zip_path
  - id: input_itp_path
    type: File
    doc: 'Path to the ligand ITP file to be inserted in the topology. Accepted formats: itp.'
    inputBinding:
      position: 1
      prefix: --input_itp_path
  - id: output_top_zip_path
    type: string
    doc: 'Path/Name the output topology TOP and ITP files zipball. Accepted formats: zip.'
    default: append_ligand_top.zip
    inputBinding:
      position: 1
      prefix: --output_top_zip_path
  - id: input_posres_itp_path
    type:
      - 'null'
      - File
    doc: 'Path to the position restriction ITP file. Accepted formats: itp.'
    inputBinding:
      position: 1
      prefix: --input_posres_itp_path
outputs:
  - id: top_zip
    type: File
    doc: 'Path/Name the output topology TOP and ITP files zipball. Accepted formats: zip.'
    outputBinding:
      glob: $(inputs.output_top_zip_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
