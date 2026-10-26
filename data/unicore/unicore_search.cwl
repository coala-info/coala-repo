cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicore
  - search
label: unicore_search
doc: |-
  Search Foldseek database against reference database

  Tool homepage: https://github.com/steineggerlab/unicore
inputs:
  - id: input
    type: File
    doc: "Input database; the primary file is the database prefix file"
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
  - id: target
    type: File
    doc: "Target database to search against"
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
      position: 2
  - id: output_prefix
    type: string
    doc: "Output prefix; the result is saved as OUTPUT.m8. The tool needs a directory part in the prefix, e.g. ./hits"
    inputBinding:
      position: 3
  - id: tmp_dir
    type: string
    doc: "Temp directory"
    inputBinding:
      position: 4
  - id: keep_aln_db
    type: ['null', boolean]
    doc: "Keep intermediate Foldseek alignment database"
    inputBinding:
      position: 10
      prefix: --keep-aln-db
  - id: search_options
    type: ['null', string]
    doc: "Arguments for foldseek options in string e.g. -s \"-c 0.8\" (default \"-c 0.8\")"
    inputBinding:
      position: 10
      prefix: --search-options
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
  - id: hits
    type: File
    doc: Search result table (OUTPUT.m8)
    outputBinding:
      glob: $(inputs.output_prefix).m8
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
