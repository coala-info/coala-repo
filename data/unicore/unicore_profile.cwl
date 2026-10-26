cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicore
  - profile
label: unicore_profile
doc: |-
  Create core structures from Foldseek database

  Tool homepage: https://github.com/steineggerlab/unicore
inputs:
  - id: input_db
    type: File
    doc: "Input database (createdb output); the primary file is the database prefix file"
    secondaryFiles:
      - '.dbtype'
      - '.index'
      - '.lookup'
      - '.map'
      - '.source'
      - '_h'
      - '_h.dbtype'
      - '_h.index'
      - '_ss'
      - '_ss.dbtype'
      - '_ss.index'
    inputBinding:
      position: 1
  - id: input_tsv
    type: File
    doc: "Input tsv file (cluster or search output)"
    inputBinding:
      position: 2
  - id: output_directory
    type: string
    doc: "Output directory"
    inputBinding:
      position: 3
  - id: threshold
    type: ['null', int]
    doc: "Coverage threshold for core structures. [0 - 100] (default 80)"
    inputBinding:
      position: 10
      prefix: --threshold
  - id: print_copiness
    type: ['null', boolean]
    doc: "Generate tsv with copy number statistics"
    inputBinding:
      position: 10
      prefix: --print-copiness
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use; 0 to use all (default 0)"
    inputBinding:
      position: 10
      prefix: --threads
  - id: verbosity
    type: ['null', int]
    doc: "Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) (default 3)"
    inputBinding:
      position: 10
      prefix: --verbosity
outputs:
  - id: core_structures
    type: Directory
    doc: Output directory with one list file per core structure
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
