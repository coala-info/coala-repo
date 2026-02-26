cwlVersion: v1.2
class: CommandLineTool
baseCommand: derna
label: derna
doc: "RNA secondary structure prediction and evaluation tool.\n\nTool homepage: https://github.com/elkebir-group/derna"
inputs:
  - id: codon_usage_table
    type:
      - 'null'
      - File
    doc: codon usage table file path
    inputBinding:
      position: 101
      prefix: --codon_usage_table
  - id: energy_params_dir
    type:
      - 'null'
      - Directory
    doc: directory to energy parameters
    inputBinding:
      position: 101
      prefix: --directory
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file path
    inputBinding:
      position: 101
      prefix: --input
  - id: input_rna_file
    type:
      - 'null'
      - File
    doc: input rna file path
    inputBinding:
      position: 101
      prefix: --input_rna
  - id: lambda
    type:
      - 'null'
      - float
    doc: lambda value for balancing MFE and CAI
    inputBinding:
      position: 101
      prefix: --lambda
  - id: min_gap_nussinov
    type:
      - 'null'
      - int
    doc: minimum gap allowed in Nussinov
    inputBinding:
      position: 101
      prefix: --min_gap
  - id: mode
    type:
      - 'null'
      - int
    doc: 1 for MFE only, 2 for balancing MFE and CAI at fixed lambda, 3 for 
      lambda sweep
    inputBinding:
      position: 101
      prefix: --mode
  - id: model
    type:
      - 'null'
      - int
    doc: 0 for Nussinov-based model, 1 for Zuker-based model, -1 for Evaluation
    inputBinding:
      position: 101
      prefix: --model
  - id: sweep_increment
    type:
      - 'null'
      - float
    doc: sweep increment for lambda sweep
    inputBinding:
      position: 101
      prefix: --sweep_increment
  - id: threshold_tau1
    type:
      - 'null'
      - float
    doc: threshold tau1
    inputBinding:
      position: 101
      prefix: --threshold_tau1
  - id: threshold_tau2
    type:
      - 'null'
      - float
    doc: threshold tau2
    inputBinding:
      position: 101
      prefix: --threshold_tau2
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file path
    outputBinding:
      glob: $(inputs.output_file)
  - id: sweep_output_csv
    type:
      - 'null'
      - File
    doc: sweep output csv file name
    outputBinding:
      glob: $(inputs.sweep_output_csv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/derna:1.0.4--h503566f_1
