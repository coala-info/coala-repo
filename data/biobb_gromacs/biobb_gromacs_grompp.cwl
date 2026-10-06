cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grompp
label: biobb_gromacs_grompp
doc: "Wrapper for the GROMACS grompp module.\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Properties file. This file can be a YAML file, JSON file or JSON string
    inputBinding:
      position: 1
      prefix: --config
  - id: input_gro_path
    type: File
    doc: 'Path to the input GROMACS structure GRO file. Accepted formats: gro.'
    inputBinding:
      position: 1
      prefix: --input_gro_path
  - id: input_top_zip_path
    type: File
    doc: 'Path to the input GROMACS topology TOP and ITP files in zip format. Accepted formats: zip.'
    inputBinding:
      position: 1
      prefix: --input_top_zip_path
  - id: output_tpr_path
    type: string
    doc: 'Path to the output portable binary run file TPR. Accepted formats: tpr.'
    default: grompp.tpr
    inputBinding:
      position: 1
      prefix: --output_tpr_path
  - id: input_cpt_path
    type:
      - 'null'
      - File
    doc: 'Path to the input GROMACS checkpoint file CPT. Accepted formats: cpt.'
    inputBinding:
      position: 1
      prefix: --input_cpt_path
  - id: input_ndx_path
    type:
      - 'null'
      - File
    doc: 'Path to the input GROMACS index files NDX. Accepted formats: ndx.'
    inputBinding:
      position: 1
      prefix: --input_ndx_path
  - id: input_mdp_path
    type:
      - 'null'
      - File
    doc: 'Path to the input GROMACS `MDP file <http://manual.gromacs.org/current/user-guide/mdp-options.html>`_. Accepted formats: mdp.'
    inputBinding:
      position: 1
      prefix: --input_mdp_path
outputs:
  - id: tpr
    type: File
    doc: 'Path to the output portable binary run file TPR. Accepted formats: tpr.'
    outputBinding:
      glob: $(inputs.output_tpr_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
