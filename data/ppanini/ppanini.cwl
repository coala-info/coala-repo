cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanini
label: ppanini
doc: "ppanini\n\nTool homepage: http://huttenhower.sph.harvard.edu/ppanini"
inputs:
  - id: abundance_detection_level
    type:
      - 'null'
      - float
    doc: Detection level of normalized relative abundance
    inputBinding:
      position: 101
      prefix: --abundance-detection-level
  - id: basename
    type:
      - 'null'
      - string
    doc: BASENAME for all the output files
    inputBinding:
      position: 101
      prefix: --basename
  - id: beta
    type:
      - 'null'
      - float
    doc: Beta parameter for weights on percentiles
    inputBinding:
      position: 101
      prefix: --beta
  - id: input_table
    type: File
    doc: 'REQUIRED: Gene abundance table with metadata'
    inputBinding:
      position: 101
      prefix: --input_table
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Choices: [DEBUG, INFO, WARNING, ERROR, CRITICAL]'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: tshld_abund
    type:
      - 'null'
      - float
    doc: '[X] Percentile Cutoff for Abundance; Default=75th'
    inputBinding:
      position: 101
      prefix: --tshld-abund
  - id: tshld_prev
    type:
      - 'null'
      - float
    doc: Percentile cutoff for Prevalence
    inputBinding:
      position: 101
      prefix: --tshld-prev
  - id: uniref2go
    type:
      - 'null'
      - File
    doc: uniref to GO term mapping file
    inputBinding:
      position: 101
      prefix: --uniref2go
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Folder containing results
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanini:0.7.4--py_0
