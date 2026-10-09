cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmc_tools
label: kmc_tools_complex
doc: "kmc_tools complex performs set operations on more than two KMC databases, defined in an operations file.\n\nTool homepage: https://github.com/refresh-bio/KMC"
inputs:
  - id: total_threads
    type: ['null', int]
    doc: "Total number of threads (default: no. of CPU cores)"
    inputBinding:
      position: 1
      prefix: "-t"
      separate: false
  - id: verbose
    type: ['null', boolean]
    doc: "Enable verbose mode (shows some information)"
    inputBinding:
      position: 2
      prefix: "-v"
  - id: hide_percentage_progress
    type: ['null', boolean]
    doc: "Hide percentage progress"
    inputBinding:
      position: 3
      prefix: "-hp"
  - id: operations_file
    type: File
    doc: "Operations definition file (INPUT:, OUTPUT: and OUTPUT_PARAMS: sections); the database prefixes in it must name files given in database_files"
    inputBinding:
      position: 10
  - id: database_files
    type:
      type: array
      items: File
    doc: "KMC database files (.kmc_pre and .kmc_suf) named in the operations file, staged in the working directory"
  - id: output_name
    type: string
    doc: "Name of the output database as written in the operations file (used to collect the result)"
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Output database files"
    outputBinding:
      glob:
        - $(inputs.output_name).kmc_*
        - $(inputs.output_name).kff
  - id: stdout
    type: stdout
    doc: "Standard output"
arguments:
  - position: 4
    valueFrom: complex
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.database_files)
      - $(inputs.operations_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmc:3.2.4--h5ca1c30_4
stdout: kmc_tools_complex.out
