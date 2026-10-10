cwlVersion: v1.2
class: CommandLineTool
baseCommand: [vcf_to_matrix]
label: nasp_vcf_to_matrix
doc: "Convert VCF and Frankenfasta files into NASP matrices and statistics.\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: mode
    type: string
    doc: "Data passing mode, commandline or xml."
    inputBinding:
      position: 1
      prefix: --mode
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: "Path to input reference fasta file."
    inputBinding:
      position: 1
      prefix: --reference-fasta
  - id: reference_dups
    type:
      - 'null'
      - File
    doc: "Path to input reference dups file."
    inputBinding:
      position: 1
      prefix: --reference-dups
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Path to input VCF/fasta files for matrix conversion."
    inputBinding:
      position: 1
      prefix: --input-files
  - id: matrix_folder
    type:
      - 'null'
      - string
    doc: "Name of folder to write output matrices to."
    inputBinding:
      position: 1
      prefix: --matrix-folder
  - id: stats_folder
    type:
      - 'null'
      - string
    doc: "Name of folder to write statistics files to."
    inputBinding:
      position: 1
      prefix: --stats-folder
  - id: minimum_coverage
    type:
      - 'null'
      - int
    doc: "Minimum coverage depth at a position."
    inputBinding:
      position: 1
      prefix: --minimum-coverage
  - id: minimum_proportion
    type:
      - 'null'
      - float
    doc: "Minimum proportion of reads that must match the call at a position."
    inputBinding:
      position: 1
      prefix: --minimum-proportion
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use when processing input."
    inputBinding:
      position: 1
      prefix: --num-threads
  - id: dto_file
    type:
      - 'null'
      - File
    doc: "Path to a matrix_dto XML file that defines all the parameters."
    inputBinding:
      position: 1
      prefix: --dto-file
outputs:
  - id: matrices
    type:
      type: array
      items: File
    doc: "Matrix and statistics files."
    outputBinding:
      glob: "*.tsv"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
