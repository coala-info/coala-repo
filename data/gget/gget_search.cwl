cwlVersion: v1.2
class: CommandLineTool
baseCommand: gget_search
label: gget_search
doc: "Fetch gene and transcript IDs from Ensembl using free-form search terms.\n\n\
  Tool homepage: https://github.com/pachterlab/gget"
inputs:
  - id: searchwords
    type:
      type: array
      items: string
    doc: One or more free form search words, e.g. gaba, nmda.
    inputBinding:
      position: 1
  - id: andor
    type:
      - 'null'
      - string
    doc: "'or': Gene descriptions must include at least one of the searchwords (default).\n\
      \                        'and': Only return genes whose descriptions include
      all searchwords. (default: or)"
    default: or
    inputBinding:
      position: 102
      prefix: --andor
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Returns results in csv format instead of json.
    inputBinding:
      position: 102
      prefix: --csv
  - id: id_type
    type:
      - 'null'
      - string
    doc: "'gene': Returns genes that match the searchwords. (default).\n         \
      \               'transcript': Returns transcripts that match the searchwords.
      (default: gene)"
    default: gene
    inputBinding:
      position: 102
      prefix: --id_type
  - id: json
    type:
      - 'null'
      - boolean
    doc: DEPRECATED - json is now the default output format (convert to csv 
      using flag [--csv]).
    inputBinding:
      position: 102
      prefix: --json
  - id: limit
    type:
      - 'null'
      - int
    doc: 'Limits the number of results, e.g. 10 (default: None).'
    inputBinding:
      position: 102
      prefix: --limit
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: release
    type:
      - 'null'
      - int
    doc: "Defines the Ensembl release number from which the files are fetched, e.g.
      104.\n                        Note: Does not apply to invertebrate species (you
      can pass a specific core database (which include a release number) to the species
      argument instead).\n                        This argument is overwritten if
      a specific database (which includes a release number) is passed to the species
      argument.\n                        Default: None -> latest Ensembl release is
      used."
    inputBinding:
      position: 102
      prefix: --release
  - id: seqtype
    type:
      - 'null'
      - string
    doc: DEPRECATED - use argument 'id_type' instead.
    inputBinding:
      position: 102
      prefix: --seqtype
  - id: species
    type: string
    doc: "Species or database to be queried, e.g. 'homo_sapiens' or 'arabidopsis_thaliana'.\n\
      \                        To pass a specific database, pass the name of the CORE
      database, e.g. 'mus_musculus_dba2j_core_105_1'.\n                        All
      available core databases can be found here:\n                        Vertebrates:
      http://ftp.ensembl.org/pub/current/mysql/\n                        Invertebrates:
      http://ftp.ensemblgenomes.org/pub/current/ + kingdom + mysql/\n            \
      \            Supported shortcuts: 'human', 'mouse'."
    inputBinding:
      position: 102
      prefix: --species
  - id: sw_deprecated
    type:
      - 'null'
      - type: array
        items: string
    doc: DEPRECATED - use positional argument instead. One or more free form 
      search words, e.g. gaba, nmda.
    inputBinding:
      position: 102
      prefix: --searchwords
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: "Path to the file the results will be saved in, e.g. path/to/directory/results.json.\n\
      \                        Default: Standard out."
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
