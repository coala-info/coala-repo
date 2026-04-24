cwlVersion: v1.2
class: CommandLineTool
baseCommand: prince
label: prince
doc: "Prince Options.\n\nTool homepage: https://github.com/WGS-TB/PythonPrince"
inputs:
  - id: boost_output
    type:
      - 'null'
      - string
    doc: output file for training data / training data used to predict copy 
      numbers for queries
    inputBinding:
      position: 101
      prefix: --boost_output
  - id: boosting_file
    type:
      - 'null'
      - File
    doc: training genome file names in a text file
    inputBinding:
      position: 101
      prefix: --boosting_file
  - id: copynumber
    type:
      - 'null'
      - int
    doc: Copy number for training genome.
    inputBinding:
      position: 101
      prefix: --copynumber
  - id: k
    type:
      - 'null'
      - int
    doc: Kmer size used during read recruitment.
    inputBinding:
      position: 101
      prefix: --k
  - id: num_procs
    type:
      - 'null'
      - int
    doc: Number of cores for parallel processing.
    inputBinding:
      position: 101
      prefix: --num_procs
  - id: primers
    type:
      - 'null'
      - string
    doc: Flanking sequences used in coverage adjustments
    inputBinding:
      position: 101
      prefix: --primers
  - id: target_file
    type:
      - 'null'
      - File
    doc: target genome names in a text file
    inputBinding:
      position: 101
      prefix: --target_file
  - id: target_output
    type:
      - 'null'
      - string
    doc: output file for query copy number predictions
    inputBinding:
      position: 101
      prefix: --target_output
  - id: templates
    type:
      - 'null'
      - string
    doc: VNTR templates. Default is for M.TB
    inputBinding:
      position: 101
      prefix: --templates
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prince:2.3--py_0
stdout: prince.out
