cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracs
  - build-db
label: tracs_build-db
doc: "Builds a database for tracs\n\nTool homepage: https://github.com/gtonkinhill/tracs"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: path to genome fasta files (one per reference genome). A single file is read
      as a list with one 'name,path' line per genome.
    inputBinding:
      position: 1
      prefix: --input
  - id: db_name
    type: string
    doc: name of the database file; the tool adds .zip to this name
    inputBinding:
      position: 2
      prefix: --output
  - id: ksize
    type:
      - 'null'
      - int
    doc: the kmer length used in sourmash
    inputBinding:
      position: 103
      prefix: --ksize
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the logging threshold.
    inputBinding:
      position: 103
      prefix: --loglevel
  - id: scale
    type:
      - 'null'
      - int
    doc: the scale used in sourmash
    inputBinding:
      position: 103
      prefix: --scale
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: database
    type: File
    doc: The database zip file (the tool adds .zip to the given name)
    outputBinding:
      glob: $(inputs.db_name).zip
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
stdout: tracs_build-db.out
