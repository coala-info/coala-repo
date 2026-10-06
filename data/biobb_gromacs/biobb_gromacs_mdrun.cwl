cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mdrun
label: biobb_gromacs_mdrun
doc: "Wrapper for the GROMACS mdrun module.\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Properties file. This file can be a YAML file, JSON file or JSON string
    inputBinding:
      position: 1
      prefix: --config
  - id: input_tpr_path
    type: File
    doc: 'Path to the portable binary run input file TPR. Accepted formats: tpr.'
    inputBinding:
      position: 1
      prefix: --input_tpr_path
  - id: output_gro_path
    type: string
    doc: 'Path to the output GROMACS structure GRO file. Accepted formats: gro.'
    default: mdrun.gro
    inputBinding:
      position: 1
      prefix: --output_gro_path
  - id: output_edr_path
    type: string
    doc: 'Path to the output GROMACS portable energy file EDR. Accepted formats: edr.'
    default: mdrun.edr
    inputBinding:
      position: 1
      prefix: --output_edr_path
  - id: output_log_path
    type: string
    doc: 'Path to the output GROMACS trajectory log file LOG. Accepted formats: log.'
    default: mdrun.log
    inputBinding:
      position: 1
      prefix: --output_log_path
  - id: output_trr_path
    type:
      - 'null'
      - string
    doc: 'Path to the GROMACS uncompressed raw trajectory file TRR. Accepted formats: trr.'
    inputBinding:
      position: 1
      prefix: --output_trr_path
  - id: input_cpt_path
    type:
      - 'null'
      - File
    doc: 'Path to the input GROMACS checkpoint file CPT. Accepted formats: cpt.'
    inputBinding:
      position: 1
      prefix: --input_cpt_path
  - id: output_xtc_path
    type:
      - 'null'
      - string
    doc: 'Path to the GROMACS compressed trajectory file XTC. Accepted formats: xtc.'
    inputBinding:
      position: 1
      prefix: --output_xtc_path
  - id: output_cpt_path
    type:
      - 'null'
      - string
    doc: 'Path to the output GROMACS checkpoint file CPT. Accepted formats: cpt.'
    inputBinding:
      position: 1
      prefix: --output_cpt_path
  - id: output_dhdl_path
    type:
      - 'null'
      - string
    doc: 'Path to the output dhdl.xvg file only used when free energy calculation is turned on. Accepted formats: xvg.'
    inputBinding:
      position: 1
      prefix: --output_dhdl_path
outputs:
  - id: gro
    type: File
    doc: 'Path to the output GROMACS structure GRO file. Accepted formats: gro.'
    outputBinding:
      glob: $(inputs.output_gro_path)
  - id: edr
    type: File
    doc: 'Path to the output GROMACS portable energy file EDR. Accepted formats: edr.'
    outputBinding:
      glob: $(inputs.output_edr_path)
  - id: log
    type: File
    doc: 'Path to the output GROMACS trajectory log file LOG. Accepted formats: log.'
    outputBinding:
      glob: $(inputs.output_log_path)
  - id: trr
    type:
      - 'null'
      - File
    doc: 'Path to the GROMACS uncompressed raw trajectory file TRR. Accepted formats: trr.'
    outputBinding:
      glob: $(inputs.output_trr_path)
  - id: xtc
    type:
      - 'null'
      - File
    doc: 'Path to the GROMACS compressed trajectory file XTC. Accepted formats: xtc.'
    outputBinding:
      glob: $(inputs.output_xtc_path)
  - id: cpt
    type:
      - 'null'
      - File
    doc: 'Path to the output GROMACS checkpoint file CPT. Accepted formats: cpt.'
    outputBinding:
      glob: $(inputs.output_cpt_path)
  - id: dhdl
    type:
      - 'null'
      - File
    doc: 'Path to the output dhdl.xvg file only used when free energy calculation is turned on. Accepted formats: xvg.'
    outputBinding:
      glob: $(inputs.output_dhdl_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
