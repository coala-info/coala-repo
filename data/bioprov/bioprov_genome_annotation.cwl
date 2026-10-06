cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioprov
  - genome_annotation
label: bioprov_genome_annotation
doc: "Genome annotation with Prodigal, Prokka and the COG database.\n\nTool homepage:
  https://github.com/vinisalazar/BioProv"
inputs:
  - id: cpus
    type:
      - 'null'
      - int
    doc: Default is set in BioProv config (half of the CPUs).
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
  - id: assemblies
    type:
      - 'null'
      - type: array
        items: File
    doc: Assembly FASTA files named in the 'assembly' column of the input table (staged
      writable in the working directory so the table can name them by file name; outputs
      are written beside them)
  - id: log
    type:
      - 'null'
      - string
    doc: "Path to write log file to. If not set, will be defined\nautomatically."
    inputBinding:
      position: 101
      prefix: --log
  - id: sep
    type:
      - 'null'
      - string
    doc: Separator for the tab-delimited file.
    inputBinding:
      position: 101
      prefix: --sep
  - id: steps
    type:
      - 'null'
      - string
    doc: "A comma-delimited string of which steps will be run in\nthe workflow. Possible
      steps: ['prodigal']"
    inputBinding:
      position: 101
      prefix: --steps
  - id: tag
    type:
      - 'null'
      - string
    doc: A tag for the Project
    inputBinding:
      position: 101
      prefix: --tag
  - id: update_db
    type:
      - 'null'
      - boolean
    doc: Whether to update the Project in the BioProvDB.
    inputBinding:
      position: 101
      prefix: --update_db
  - id: upload_to_provstore
    type:
      - 'null'
      - boolean
    doc: "Whether to upload the Project to ProvStore at the end\nof the execution."
    inputBinding:
      position: 101
      prefix: --upload_to_provstore
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: More verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: write_pdf
    type:
      - 'null'
      - boolean
    doc: "Whether to write graphical output at the end of the\nexecution."
    inputBinding:
      position: 101
      prefix: --write_pdf
  - id: write_provn
    type:
      - 'null'
      - boolean
    doc: "Whether to write PROVN output at the end of the\nexecution."
    inputBinding:
      position: 101
      prefix: --write_provn
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: proteins
    type: File[]
    doc: Prodigal protein translations
    outputBinding:
      glob: '*_proteins.faa'
  - id: genes
    type: File[]
    doc: Prodigal gene nucleotide sequences
    outputBinding:
      glob: '*_genes.fna'
  - id: scores
    type: File[]
    doc: Prodigal gene scores
    outputBinding:
      glob: '*_scores.cds'
  - id: log_file
    type: File[]
    doc: BioProv log file
    outputBinding:
      glob: '*.log'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.assemblies)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioprov:0.1.23--pyh5e36f6f_0
stdout: bioprov_genome_annotation.out
