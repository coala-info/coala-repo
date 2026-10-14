cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylophlan_assign_sgbs
label: phylophlan_assign_sgbs
doc: "Assigns the SGB and taxonomy to a given set of input genomes.\n\nTool homepage: https://github.com/biobakery/phylophlan"
inputs:
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: "Input folder containing genomes to be indexed"
    inputBinding:
      position: 1
      prefix: "--input_directory"
  - id: input_extension
    type:
      - 'null'
      - string
    doc: "Extension of the input file(s); if not specified all files in the directory are used"
    inputBinding:
      position: 1
      prefix: "--input_extension"
  - id: output_directory
    type:
      - 'null'
      - string
    doc: "Output directory"
    inputBinding:
      position: 1
      prefix: "--output_directory"
  - id: database_folder
    type:
      - 'null'
      - Directory
    doc: "Folder that contains the database file (default: phylophlan_databases/)"
    inputBinding:
      position: 1
      prefix: "--database_folder"
  - id: database
    type:
      - 'null'
      - string
    doc: "Database name"
    inputBinding:
      position: 1
      prefix: "--database"
  - id: list_databases
    type:
      - 'null'
      - boolean
    doc: "List all the available databases"
    inputBinding:
      position: 1
      prefix: "--list_databases"
  - id: nproc_cpu
    type:
      - 'null'
      - int
    doc: "Number of threads for CPU intensive jobs (default: 1)"
    inputBinding:
      position: 1
      prefix: "--nproc_cpu"
  - id: nproc_io
    type:
      - 'null'
      - int
    doc: "Number of CPUs for I/O intensive jobs (default: 1)"
    inputBinding:
      position: 1
      prefix: "--nproc_io"
  - id: clean
    type:
      - 'null'
      - boolean
    doc: "Clean the temporary directory (don't reuse intermediate results)"
    inputBinding:
      position: 1
      prefix: "--clean"
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Assignment results"
    outputBinding:
      glob: "$(inputs.output_directory)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
stdout: phylophlan_assign_sgbs.out
