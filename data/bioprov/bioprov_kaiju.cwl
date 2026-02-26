cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju
label: bioprov_kaiju
doc: "Run Kaiju on metagenomic data and create reports for taxonomic ranks.\n\nTool
  homepage: https://github.com/vinisalazar/BioProv"
inputs:
  - id: input
    type: File
    doc: "Input file, a tab delimited file which must contain three columns: 'sample-id',
      'R1', and 'R2', containing respectively sample IDs, _path to forward reads and
      _path to reverse reads."
    inputBinding:
      position: 101
      prefix: --input
  - id: kaiju2table_params
    type:
      - 'null'
      - string
    doc: Parameter string to be added to Kaiju2table command.
    inputBinding:
      position: 101
      prefix: --kaiju2table_params
  - id: kaiju_db
    type: File
    doc: Kaiju database file.
    inputBinding:
      position: 101
      prefix: --kaiju_db
  - id: kaiju_params
    type:
      - 'null'
      - string
    doc: Parameter string to be added to Kaiju command.
    inputBinding:
      position: 101
      prefix: --kaiju_params
  - id: names
    type: File
    doc: NCBI Taxonomy names.dmp file required to run Kaiju2Table.
    inputBinding:
      position: 101
      prefix: --names
  - id: nodes
    type: File
    doc: NCBI Taxonomy nodes.dmp file required to run Kaiju.
    inputBinding:
      position: 101
      prefix: --nodes
  - id: tag
    type:
      - 'null'
      - string
    doc: A tag for the dataset
    inputBinding:
      position: 101
      prefix: --tag
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Default is set in BioProv config (half of the 
      threads).
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: More verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory to create Kaiju files. Default is directory of input 
      file.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioprov:0.1.23--pyh5e36f6f_0
