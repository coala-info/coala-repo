cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicore
  - cluster
label: unicore_cluster
doc: |-
  Cluster Foldseek database

  Tool homepage: https://github.com/steineggerlab/unicore
inputs:
  - id: input_database
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
  - id: output_prefix
    type: string
    doc: "Output prefix; the result is saved as OUTPUT.tsv. The tool needs a directory part in the prefix, e.g. ./clu"
    inputBinding:
      position: 2
  - id: tmp_directory
    type: string
    doc: "Temp directory"
    inputBinding:
      position: 3
  - id: keep_cluster_db
    type: ['null', boolean]
    doc: "Keep intermediate Foldseek cluster database"
    inputBinding:
      position: 10
      prefix: --keep-cluster-db
  - id: cluster_options
    type: ['null', string]
    doc: "Arguments for foldseek options in string e.g. -c \"-c 0.8\" (default \"-c 0.8\")"
    inputBinding:
      position: 10
      prefix: --cluster-options
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
  - id: cluster_tsv
    type: File
    doc: Cluster table (OUTPUT.tsv)
    outputBinding:
      glob: $(inputs.output_prefix).tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
