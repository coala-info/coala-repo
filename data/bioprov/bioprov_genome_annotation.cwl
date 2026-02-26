cwlVersion: v1.2
class: CommandLineTool
baseCommand: genome_annotation
label: bioprov_genome_annotation
doc: "Genome annotation with Prodigal, Prokka and the COG database.\n\nTool homepage:
  https://github.com/vinisalazar/BioProv"
inputs:
  - id: cpus
    type:
      - 'null'
      - int
    doc: Default is set in BioProv config (half of the CPUs).
    default: 10
    inputBinding:
      position: 101
      prefix: --cpus
  - id: input
    type: File
    doc: "Input file, may be a tab delimited file or a\ndirectory. If a file, must
      contain column 'sample-id'\nfor sample ID and 'assembly' for files. See program\n\
      help for information."
    inputBinding:
      position: 101
      prefix: --input
  - id: log
    type:
      - 'null'
      - File
    doc: "Path to write log file to. If not set, will be defined\nautomatically."
    default: None
    inputBinding:
      position: 101
      prefix: --log
  - id: sep
    type:
      - 'null'
      - string
    doc: Separator for the tab-delimited file.
    default: ''
    inputBinding:
      position: 101
      prefix: --sep
  - id: steps
    type:
      - 'null'
      - string
    doc: "A comma-delimited string of which steps will be run in\nthe workflow. Possible
      steps: ['prodigal']"
    default: "['prodigal']"
    inputBinding:
      position: 101
      prefix: --steps
  - id: tag
    type:
      - 'null'
      - string
    doc: A tag for the Project
    default: None
    inputBinding:
      position: 101
      prefix: --tag
  - id: update_db
    type:
      - 'null'
      - boolean
    doc: Whether to update the Project in the BioProvDB.
    default: false
    inputBinding:
      position: 101
      prefix: --update_db
  - id: upload_to_provstore
    type:
      - 'null'
      - boolean
    doc: "Whether to upload the Project to ProvStore at the end\nof the execution."
    default: false
    inputBinding:
      position: 101
      prefix: --upload_to_provstore
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: More verbose output
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
  - id: write_pdf
    type:
      - 'null'
      - boolean
    doc: "Whether to write graphical output at the end of the\nexecution."
    default: false
    inputBinding:
      position: 101
      prefix: --write_pdf
  - id: write_provn
    type:
      - 'null'
      - boolean
    doc: "Whether to write PROVN output at the end of the\nexecution."
    default: false
    inputBinding:
      position: 101
      prefix: --write_provn
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioprov:0.1.23--pyh5e36f6f_0
stdout: bioprov_genome_annotation.out
