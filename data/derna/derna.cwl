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
      prefix: -c
  - id: energy_params_dir
    type:
      - 'null'
      - Directory
    doc: directory to energy parameters
    inputBinding:
      position: 101
      prefix: -d
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file path
    inputBinding:
      position: 101
      prefix: -i
  - id: input_rna_file
    type:
      - 'null'
      - File
    doc: input rna file path
    inputBinding:
      position: 101
      prefix: -r
  - id: lambda
    type:
      - 'null'
      - float
    doc: lambda value for balancing MFE and CAI
    inputBinding:
      position: 101
      prefix: -l
  - id: min_gap_nussinov
    type:
      - 'null'
      - int
    doc: minimum gap allowed in Nussinov
    inputBinding:
      position: 101
      prefix: -g
  - id: mode
    type:
      - 'null'
      - int
    doc: 1 for MFE only, 2 for balancing MFE and CAI at fixed lambda, 3 for 
      lambda sweep
    inputBinding:
      position: 101
      prefix: -s
  - id: model
    type:
      - 'null'
      - int
    doc: 0 for Nussinov-based model, 1 for Zuker-based model, -1 for Evaluation
    inputBinding:
      position: 101
      prefix: -m
  - id: sweep_increment
    type:
      - 'null'
      - float
    doc: sweep increment for lambda sweep
    inputBinding:
      position: 101
      prefix: -a
  - id: threshold_tau1
    type:
      - 'null'
      - float
    doc: threshold tau1
    inputBinding:
      position: 101
      prefix: -t
  - id: threshold_tau2
    type:
      - 'null'
      - float
    doc: threshold tau2
    inputBinding:
      position: 101
      prefix: -p
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: -- output file path
    inputBinding:
      position: 102
      prefix: -o
  - id: sweep_output_csv_path
    type:
      - 'null'
      - string
    doc: -- sweep output csv file name
    inputBinding:
      position: 103
      prefix: -O
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file path
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: sweep_output_csv
    type:
      - 'null'
      - File
    doc: sweep output csv file name
    outputBinding:
      glob: $(inputs.sweep_output_csv_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/derna:1.0.4--h503566f_1
