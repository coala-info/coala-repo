cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nasp, matrix]
label: nasp_matrix
doc: "Aggregate the VCF and Frankenfasta files from the NASP pipeline into .tsv matrix and stats file summaries.\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: dto_file
    type:
      - 'null'
      - File
    doc: "Path to the matrix_dto.xml file."
    inputBinding:
      position: 1
      prefix: --dto-file
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Max number of CPUs that can be executing simultaneously (default: all)."
    inputBinding:
      position: 1
      prefix: --num-threads
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: "Reference fasta against which samples are compared."
    inputBinding:
      position: 1
      prefix: --reference-fasta
  - id: reference_dups
    type:
      - 'null'
      - File
    doc: "duplicates.txt file marking duplicated positions."
    inputBinding:
      position: 1
      prefix: --reference-dups
  - id: stats_folder
    type:
      - 'null'
      - string
    doc: "Output folder for statistics (default: ./)."
    inputBinding:
      position: 1
      prefix: --stats-folder
  - id: matrix_folder
    type:
      - 'null'
      - string
    doc: "Output folder for matrices (default: ./)."
    inputBinding:
      position: 1
      prefix: --matrix-folder
  - id: minimum_coverage
    type:
      - 'null'
      - int
    doc: "Filter positions below this coverage/depth threshold (default: 0)."
    inputBinding:
      position: 1
      prefix: --minimum-coverage
  - id: minimum_proportion
    type:
      - 'null'
      - float
    doc: "Filter positions below this proportion threshold (default: 0.0)."
    inputBinding:
      position: 1
      prefix: --minimum-proportion
  - id: withallrefpos
    type:
      - 'null'
      - boolean
    doc: "Include the withallrefpos.tsv matrix."
    inputBinding:
      position: 1
      prefix: --withallrefpos
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "VCF and Frankenfasta files to aggregate."
    inputBinding:
      position: 101
outputs:
  - id: output
    type: stdout
    doc: "Standard output of the matrix command."
  - id: matrices
    type:
      type: array
      items: File
    doc: "Matrix and statistics files written to the working directory."
    outputBinding:
      glob: "*.tsv"
stdout: nasp_matrix.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
