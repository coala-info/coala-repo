cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmindex merge
label: kmindex_merge
doc: "Merge sub-indexes.\n\nTool homepage: https://github.com/tlemane/kmindex"
inputs:
  - id: delete_old
    type:
      - 'null'
      - boolean
    doc: Delete old sub-index files.
    inputBinding:
      position: 101
      prefix: --delete-old
  - id: index
    type: string
    doc: Global index path.
    inputBinding:
      position: 101
      prefix: --index
  - id: new_name
    type: string
    doc: Name of the new index.
    inputBinding:
      position: 101
      prefix: --new-name
  - id: new_path
    type: string
    doc: Output path.
    inputBinding:
      position: 101
      prefix: --new-path
  - id: rename
    type:
      - 'null'
      - string
    doc: "Rename sample ids.\n                      - A sub-index cannot contain samples
      with similar identifiers.\n                        Sub-indexes containing identical
      identifiers cannot be merged, the\n                        identifiers must
      be renamed.\n                      - Renaming can be done in three different
      ways:\n\n                        1. Using identifier files (one per line).\n\
      \                           For example, if you want to merge three sub-indexes:\n\
      \                             '-r f:id1.txt,id2.txt,id3.txt'\n\n           \
      \             2. Using a format string ('{}' is replaced by an integer in [0,
      nb_samples)).\n                             '-r \"s:id_{}\"'\n\n           \
      \             3. Manually (not recommended).\n                           Identifiers
      can be changed in 'kmtricks.fof' files in sub-index directories."
    inputBinding:
      position: 101
      prefix: --rename
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: to_merge
    type:
      type: array
      items: string
    doc: Sub-indexes to merge, comma separated.
    inputBinding:
      position: 101
      prefix: --to-merge
  - id: verbose
    type:
      - 'null'
      - string
    doc: Verbosity level [debug|info|warning|error].
    default: info
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
stdout: kmindex_merge.out
